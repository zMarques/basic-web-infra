criar bucket

mudar variaveis /variables.tf 

criar arquivo env = env.tfvars
{
  ssh_public_key = ""
}

terraform apply -var-file=env.tfvars --auto-approve

copiar public IP

colocar no secrets das apps

HOST=
ssh_public_key=