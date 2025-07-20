output "proxy_public_ips" {
  value = [for instance in aws_instance.proxy : instance.public_ip]
}

output "app_private_ips" {
  value = [for instance in aws_instance.app : instance.private_ip]
}
