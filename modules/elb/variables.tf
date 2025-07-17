variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_public_sg_id" {
  type = string
}

variable "alb_internal_sg_id" {
  type = string
}

variable "proxy_instance_ids" {
  type = list(string)
}

variable "app_instance_ids" {
  type = list(string)
}
