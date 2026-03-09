output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.wordpress.id
}

output "public_ip" {
  description = "Public IP of the WordPress server"
  value       = aws_instance.wordpress.public_ip
}

output "wordpress_url" {
  description = "WordPress site URL"
  value       = "http://${aws_instance.wordpress.public_dns}"
}