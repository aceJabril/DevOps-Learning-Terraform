output "public_ip" {
  description = "Public IP of the EC2 server"
  value       = aws_instance.assignment-2.public_ip
}