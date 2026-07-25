resource "aws_security_group" "public_sg" {
  name        = "ssm-public-sg"
  description = "Allow outbound traffic for SSM agent"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
