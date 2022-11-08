resource "aws_instance" "Jenkins" {
  ami           = "ami-0149b2da6ceec4bb0"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.private_security_group.id]
  key_name = "RHEL"
  root_block_device {
        volume_size           = 20
        volume_type           = "gp2"
    }
  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "App" {
  ami           = "ami-0149b2da6ceec4bb0"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  subnet_id = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.private_security_group.id]
  key_name = "RHEL"
  root_block_device {
        volume_size           = 20
        volume_type           = "gp2"
    }
  tags = {
    Name = "app"
  }
}
