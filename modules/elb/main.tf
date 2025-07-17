# Public ALB
resource "aws_lb" "public" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_public_sg_id]
  subnets            = var.public_subnet_ids
}

# Internal ALB
resource "aws_lb" "internal" {
  name               = "internalalb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.alb_internal_sg_id]
  subnets            = var.private_subnet_ids
}

# NGINX Target Group
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Backend Target Group
resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Listeners
resource "aws_lb_listener" "public_http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

resource "aws_lb_listener" "internal_http" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

# Attach EC2 instances
resource "aws_lb_target_group_attachment" "nginx_instances" {
  count            = length(var.proxy_instance_ids)
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = var.proxy_instance_ids[count.index]
  port             = 80
}

resource "aws_lb_target_group_attachment" "backend_app" {
  count            = length(var.app_instance_ids)
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = var.app_instance_ids[count.index]
  port             = 5000
}

# Template file for nginx.conf
data "template_file" "nginx_conf" {
  template = file("./template/nginx.conf.tpl")
  vars = {
    internal_alb_dns = aws_lb.internal.dns_name
  }
}
