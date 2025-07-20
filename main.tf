module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnets      = ["10.0.0.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.1.0/24", "10.0.3.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# AMI 
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.8.20250707.0-kernel-6.1-x86_64"]
  }
  owners = ["amazon"]
}

# render nginx.conf
data "template_file" "nginx_conf" {
  template = file("${path.module}/template/nginx.conf.tpl")
  vars = {
    internal_alb_dns = module.elb.internal_lb_dns
  }
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = data.aws_ami.amazon_linux.id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  proxy_sg_id        = module.sg.proxy_sg_id
  app_sg_id          = module.sg.app_sg_id
  key_name           = "redhat"
  private_key_path   = "/home/muhammed-hamed/Downloads/redhat.pem"
  nginx_conf         = data.template_file.nginx_conf.rendered
}



module "elb" {
  source             = "./modules/elb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  public_sg_id       = module.sg.alb_public_sg_id
  internal_sg_id     = module.sg.alb_internal_sg_id
}

