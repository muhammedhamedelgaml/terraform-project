variable "ami" {}
variable "instance_type" { default = "t2.micro" }

variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "proxy_sg_id" {}
variable "app_sg_id" {}

variable "key_name" {}
variable "private_key_path" {}

variable "ssh_user" {
  default = "ec2-user"
}

variable "nginx_conf" {}
variable "frontend_script_path" {}
variable "backend_script_path" {}
