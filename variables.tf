variable "aws_region" {
  type        = string
  description = "região onde sera provisionada"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "profile da CLI da aws"
  default     = "default"
}

variable "instance_type" {
  type        = string
  description = "tipo da instancia (ex t3.small)"
  default     = "t3.small"
}

variable "instance_tags" {
  type        = map(string)
  description = "tags da instancia"
  default     = {
    "Name" = "ec2 do patinho"
    "projeto" = "cartalogo"
    "owner" = "codehall"
  }
}

variable "ssh_public_key" {
  type        = string
  description = "chave de publica para acesso remoto (id_rda.pub)"
}