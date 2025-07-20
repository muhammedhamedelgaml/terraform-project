output "public_lb_dns" {
  value = aws_lb.public.dns_name
}

output "internal_lb_dns" {
  value = aws_lb.internal.dns_name
}

output "nginx_target_group_arn" {
  value = aws_lb_target_group.nginx_tg.arn
}

output "backend_target_group_arn" {
  value = aws_lb_target_group.backend_tg.arn
}
