
resource "aws_instance" "ubuntu" {
  ami             = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg.id]
  key_name        = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "Ubuntu-server"
  }
}
