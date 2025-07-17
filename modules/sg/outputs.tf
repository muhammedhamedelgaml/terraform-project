output "alb_public_sg_id" {
  value = aws_security_group.alb_public_sg.id
}

output "proxy_sg_id" {
  value = aws_security_group.proxy_sg.id
}

output "alb_internal_sg_id" {
  value = aws_security_group.alb_internal_sg.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}
