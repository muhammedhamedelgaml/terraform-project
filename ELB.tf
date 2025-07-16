# Internal Application Load Balancer (ALB) Setup
resource "aws_lb" "internal" {
  name               = "internalalb"  # changed from "internal-alb" to be valid
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_internal_sg.id]
  subnets            = aws_subnet.private[*].id
}

# Public Application Load Balancer (ALB) Setup

resource "aws_lb" "public" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_public_sg.id]
  subnets            = aws_subnet.public[*].id
}

# Target group for NGINX reverse proxies (port 80)
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Public ALB Listener (HTTP 80)
resource "aws_lb_listener" "public_http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

# Attach NGINX EC2 instances to NGINX target group
resource "aws_lb_target_group_attachment" "nginx_instances" {
  count            = 2
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = aws_instance.proxy[count.index].id  # fixed resource name from "nginx" to "proxy"
  port             = 80
}

# Target group for backend app (port 5000)
resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Internal ALB Listener (HTTP 80)
resource "aws_lb_listener" "internal_http" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

# Attach backend EC2 instances to backend target group
resource "aws_lb_target_group_attachment" "backend_app" {
  count            = 2
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_instance.app[count.index].id
  port             = 5000
}



data "template_file" "nginx_conf" {
  template = file("./template/nginx.conf.tpl")
  vars = {
    internal_alb_dns = aws_lb.internal.dns_name
  }
}
