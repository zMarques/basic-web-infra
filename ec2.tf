
resource "aws_instance" "codehall_cartalogo_instance" {
  ami                         = "ami-08d4ac5b634553e16"
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  security_groups             = ["${aws_security_group.my_sg.name}"]

  tags = var.instance_tags
}

resource "aws_eip" "static_ip" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.codehall_cartalogo_instance.id
  allocation_id = aws_eip.static_ip.id
}
