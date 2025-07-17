output "public_alb_dns" {
  value = module.elb.public_lb_dns
}

output "internal_alb_dns" {
  value = module.elb.internal_lb_dns
}
