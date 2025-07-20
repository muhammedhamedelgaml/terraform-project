output "public_lb" {
  value =  aws_lb.public.dns_name
       
}

output "enternal_lb" {
  value =  aws_lb.internal.dns_name
}