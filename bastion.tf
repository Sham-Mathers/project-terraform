resource "aws_instance" "Bastion" {
  ami           = "ami-0149b2da6ceec4bb0"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  key_name = "RHEL"
  root_block_device {
        volume_size           = 20
        volume_type           = "gp2"
    }
  tags = {
    Name = "bastion"
  }
}
