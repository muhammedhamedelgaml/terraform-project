variable "ami_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "proxy_sg_id" {
  type = string
}

variable "app_sg_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "nginx_conf" {
  type = string
}
