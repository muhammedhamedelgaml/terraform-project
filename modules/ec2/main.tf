# EC2 Instances - Proxies
resource "aws_instance" "proxy" {
  count                     = 2
  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = var.public_subnet_ids[count.index]
  vpc_security_group_ids    = [var.proxy_sg_id]
  associate_public_ip_address = true
  key_name                  = var.key_name
  tags                      = { Name = "nginx-proxy-${count.index + 1}" }

  provisioner "local-exec" {
    command = "echo public-ip${count.index + 1} ${self.public_ip} >> all-ips.txt"  
       }

  provisioner "file" {
    content     = var.nginx_conf
    destination = "/tmp/nginx.conf"
  }

  provisioner "file" {
    source      = var.frontend_script_path
    destination = "/tmp/startApp_frontend.sh"
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.private_key_path)
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
  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = var.private_subnet_ids[count.index]
  vpc_security_group_ids    = [var.app_sg_id]
  key_name                  = var.key_name
  user_data                 = file(var.backend_script_path)
  tags                      = { Name = "web-app-${count.index + 1}" }


    provisioner "local-exec" {
    command = "echo priv-ip${count.index + 1} ${self.private_ip} >> all-ips.txt"  
       }
}
