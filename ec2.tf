# EC2 Instances - Proxies
resource "aws_instance" "proxy" {
  count                     = 2
  # ami                       = "ami-0150ccaf51ab55a51"
  ami                        =  data.aws_ami.amazon_linux.id
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.public[count.index].id
  vpc_security_group_ids    = [aws_security_group.proxy_sg.id]
  associate_public_ip_address = true
  tags                      = { Name = "nginx-proxy-${count.index + 1}" }
  key_name                  = "redhat"

   provisioner "local-exec" {
    command = "echo public-ip${count.index + 1} ${self.public_ip} >> all-ips.txt"  
       }

    provisioner "file" {
    content     = data.template_file.nginx_conf.rendered
    destination = "/tmp/nginx.conf"
  }

    provisioner "file" {
    source      = "./template/startApp_frontend.sh"
    destination = "/tmp/startApp_frontend.sh"
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"  
    private_key = file("/home/muhammed-hamed/Downloads/redhat.pem") 
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/startApp_frontend.sh",
      "sudo /tmp/startApp_frontend.sh"  
    ]
  }
 

}

# EC2 Instances - Web App
resource "aws_instance" "app" {
  count                     = 2
  # ami                       = "ami-0150ccaf51ab55a51"
  ami                        =  data.aws_ami.amazon_linux.id
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.private[count.index].id
  vpc_security_group_ids    = [aws_security_group.app_sg.id]
  tags                      = { Name = "web-app-${count.index + 1}" }
  key_name                  = "redhat"


  provisioner "local-exec" {
    command = "echo public-ip${count.index + 1} ${self.private_ip} >> all-ips.txt"  
       }

  user_data = file("./template/startApp_backend.sh")
}




data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.8.20250707.0-kernel-6.1-x86_64"] 
         }

  owners = ["amazon"] 
}
