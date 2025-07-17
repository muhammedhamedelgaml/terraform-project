module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnets      = ["10.0.0.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.1.0/24", "10.0.3.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "security_group" {
  source  = "./modules/security-group"
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source               = "./modules/ec2"
  ami                  = "ami-0150ccaf51ab55a51"
  instance_type        = "t2.micro"
  public_subnet_ids    = module.vpc.public_subnet_ids
  private_subnet_ids   = module.vpc.private_subnet_ids
  proxy_sg_id          = module.security_group.proxy_sg_id
  app_sg_id            = module.security_group.app_sg_id
  key_name             = "ubuntu"
  private_key_path     = "/home/muhammed-hamed/Downloads/ubuntu.pem"
  ssh_user             = "ec2-user"

  nginx_conf           = data.template_file.nginx_conf.rendered
  frontend_script_path = "./template/startApp_frontend.sh"
  backend_script_path  = "./template/startApp_backend.sh"
}
