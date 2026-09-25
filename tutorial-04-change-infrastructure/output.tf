output "instance_hostname" {
  description = "EC2 public DNS hostname"
  value       = aws_instance.app_server.public_dns
}

output "instance_private_dns" {
  description = "EC2 private DNS"
  value       = aws_instance.app_server.private_dns
}