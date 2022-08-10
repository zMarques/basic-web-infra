terraform {

  backend "s3" {
    region = "us-east-1" # AWS bucket region
    bucket = "bucket-name" # S3 bucket name
    key    = "terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

output "instace_ip" {
  value = aws_eip.static_ip.public_ip
}

resource "local_file" "host-file" {
    content  = aws_eip.static_ip.public_ip
    filename = "./ansible/hosts"
}

resource "null_resource" "ansible" {

  triggers = {
   trigger = timestamp()
  }

  depends_on = [local_file.host-file]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./ansible/hosts ./ansible/install-docker.yml"  
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./ansible/hosts ./ansible/infra-containers.yml"  
  }
  
}