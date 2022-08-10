Um projeto com terraform para automatizar deployment de containers web e apis.

ultilizei as ferramentas Terraform e Ansible para fazer a automação

é apenas a Base pois terei que fazer o deploy do app no repositorio do mesmo , mas esse projeto ja provisiona a maquina e roda alguns containers para axiliar como [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy) para fazer o proxy reverso e [jrcs/letsencrypt](https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion) para gerar os certificados SSL


## Passo 1

#### Instalar dependencias

- [AWS CLI](https://aws.amazon.com/pt/cli/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

#### Login na AWS CLI

```
  $ aws configure

  AWS Access Key ID [None]: ***********
  AWS Secret Access Key [None]: ***************
  Default region name [None]: us-west-1
  Default output format [None]: json
```

## Passo 2

### Configurar o Backend do Terraform

na aws va em S3 e crie um bucket,
em seguida no arquivo ./main.tf substitua os valores pelos do seu bucket criado

```
backend "s3" {
    region = "us-east-1" # AWS bucket region
    bucket = "bucket-name" # S3 bucket name
    key    = "terraform.tfstate"
  }
```

### Em seguida inicie o backend com o comando:

```
terraform init
```

## Passo 3

#### Configurar os recursos que serao provisionados

no arquivo /variables.tf mude as variaveis caso precise

```
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
```

## Passo 4

#### Criar arquivos de enviroments

No root do diretorio crie o arquivo env.tfvars

Coloque dentro dele a chave ssh publica que vc usara para acessar a maquina

```
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOQrAX5x51HDI /ZLW8PklL7ZWpYX9WClsi19a0uVBZA+bGM+B7zkEFbZiEQilclQZSzGhyJjcU1bxdhOPVnOXLDwAgJlJ1l0x0+YlDZll+7EPpEj1aAXBKQGQGf9fqoHnpcP3K2JHNJ1OH88UUHcWR/19GDTZoVXE4uJQ+f5it+U+Xvb1woKExaJCJ16wlacl16Gawni0W5D5wcXNt+1E2IirzOUD/wDzlxBJg/+stQKlf57un70yhT4lo5oKdPVWQJUq68Btxe7sei5zPYPlyacRa2aviItcRRjcVpjFXytIADsGyD1jnwIQh17BnuRjgcfRtXNjn143Qj8xivtxQzawdGh8Y4A153HIXt73yonWtdlbGhez/wUEaL3V2fApYktJxgHz3z4GvKfSiVnRIsxfRGVIUgYYGd740wK8ZJ3cfodNZ19bh80/7ueTYE7l/Vs3reQIzDsG6YSawdgZlNQ0U1EkJ/twOaKlNG5i7g0VYJ4Bkr+LDhvniaDISoITO66M= zmarques@Exemplo"
```

## Passo 5

#### Iniciar o Terraform
```
terraform apply -var-file=env.tfvars --auto-approve
```

apos a execuçao sera provisionada a infra e o IP sera mostrado
```
Outputs:

instace_ip = "18.215.24.23" #example
```
