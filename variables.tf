variable "aws_profile" {
  type        = string
  description = "profile da CLI da aws"
  default     = "default"
}

variable "aws_region" {
  type        = string
  description = "região onde sera provisionada"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "tipo da instancia (ex t3.small)"
  default     = "t3.small"
}

# tags que serao adicionadas a instancia EC2
variable "instance_tags" {
  type        = map(string)
  description = "tags da instancia"
  default     = {
    "Name" = "Nome da instancia"
    "projeto" = "nome do projeto"
    "owner" = "zMarques"
    # adicione mais tags se quiser 
  }
}

variable "ssh_public_key" {
  type        = string
  description = "chave de publica para acesso remoto (id_rda.pub)"
}