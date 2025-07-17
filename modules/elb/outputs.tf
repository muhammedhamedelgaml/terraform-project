output "proxy_instance_ids" {
  value = aws_instance.proxy[*].id
}

output "app_instance_ids" {
  value = aws_instance.app[*].id
}

output "public_lb_dns" {
  value = aws_lb.public.dns_name
}

output "internal_lb_dns" {
  value = aws_lb.internal.dns_name
}
