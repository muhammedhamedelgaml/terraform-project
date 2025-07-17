output "proxy_instance_ids" {
  value = aws_instance.proxy[*].id
}

output "app_instance_ids" {
  value = aws_instance.app[*].id
}
