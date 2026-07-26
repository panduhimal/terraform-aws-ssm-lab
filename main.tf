resource "aws_instance" "public_instance" {
  ami                         = data.aws_ami.linux.id
  instance_type               = "t2.micro"
  subnet_id                   = local.target_public_subnet_id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami                         = data.aws_ami.linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = false

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "private_instance"
  }
}

# resource "aws_instance" "private_endpoint_instance" {
#   ami                         = data.aws_ami.linux.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.private_endpoint_subnet.id
#   vpc_security_group_ids      = [aws_security_group.private_endpoint_instance_sg.id]
#   iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
#   associate_public_ip_address = false

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#   }

#   tags = {
#     Name = "private_endpoint_instance"
#   }
# }
