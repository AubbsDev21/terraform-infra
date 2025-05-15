output vpc_output {
  value       = aws_vpc.main.id
  sensitive   = false
  description = "description"
}

output public_subnet_id_output {
    value = [for subnet in aws_subnet.public : subnet.id]
  
}

output "security_group_id_tls" {
  value = [for sg in aws_vpc_security_group_ingress_rule.allow_tls : sg.id]
  
}

output "security_group_id_http" {
  value = [ for sg in aws_vpc_security_group_ingress_rule.allow_http : sg.id]
}