variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.medium"
}

variable "admin_ip" {
  description = "Seu IP para acesso administrativo (ex: 200.100.50.25/32)"
  type        = string
}