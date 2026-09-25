output "instance_public_ip" {
  description = "IP público da instância"
  value       = aws_instance.mail.public_ip
}

output "stalwart_admin_url" {
  description = "URL da interface admin do Stalwart"
  value       = "http://${aws_instance.mail.public_ip}:8080"
}

output "bulwark_url" {
  description = "URL do Bulwark Webmail"
  value       = "http://${aws_instance.mail.public_ip}:3000"
}