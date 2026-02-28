# Security group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "my-terraform-sg"       # Change to your desired name
  description = "Allow SSH inbound"
  vpc_id      = "vpc-024ab25ff63a3d405"         # Replace with your VPC ID
}

# Ingress rule for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_rule" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# EC2 instance
resource "aws_instance" "public" {
  ami                         = "ami-0ac0e4288aa341886"             # Find Amazon Linux 2023 AMI
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-07613369be510e0d0"
  associate_public_ip_address = true
  key_name                    = "ryan-terraform"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "ryan-ec2-instance"   # Replace with your naming convention
  }
}