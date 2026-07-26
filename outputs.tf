output "public_instance_id" {
  description = "The ID of public EC2 instance."
  value       = aws_instance.public_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.public_instance.public_ip
}

output "vpc_id" {
  description = "The ID of the main VPC."
  value       = data.aws_vpc.default.id
}

output "private_instance_id" {
  description = "The ID of private EC2 instance."
  value       = aws_instance.private_instance.id
}

# output "private_endpoint_instance_id" {
#   description = "The ID of private EC2 instance for VPC Endpoints."
#   value       = aws_instance.private_endpoint_instance.id
# }

output "ssm_check_command" {
  description = "AWS CLI command to verify if the SSM Agent has checked in and is Online."
  value       = "aws ssm describe-instance-information --query \"InstanceInformationList[?InstanceId=='${aws_instance.public_instance.id}'].{ID:InstanceId,Status:PingStatus}\" --output table"
}

output "ssm_connect_command" {
  description = "AWS CLI command to immediately drop into a secure interactive Session Manager shell."
  value       = "aws ssm start-session --target ${aws_instance.public_instance.id}"
}

output "private_ssm_check_command" {
  description = "AWS CLI command to verify if the private SSM Agent has checked in and is Online."
  value       = "aws ssm describe-instance-information --query \"InstanceInformationList[?InstanceId=='${aws_instance.private_instance.id}'].{ID:InstanceId,Status:PingStatus}\" --output table"
}

output "private_ssm_connect_command" {
  description = "AWS CLI command to immediately drop into a secure interactive Session Manager shell on the private instance."
  value       = "aws ssm start-session --target ${aws_instance.private_instance.id}"
}

# output "private_endpoint_ssm_check_command" {
#   description = "AWS CLI command to verify if the VPC-endpoint private instance's SSM Agent has checked in and is Online."
#   value       = "aws ssm describe-instance-information --query \"InstanceInformationList[?InstanceId=='${aws_instance.private_endpoint_instance.id}'].{ID:InstanceId,Status:PingStatus}\" --output table"
# }

# output "private_endpoint_ssm_connect_command" {
#   description = "AWS CLI command to immediately drop into a secure interactive Session Manager shell on the VPC-endpoint private instance."
#   value       = "aws ssm start-session --target ${aws_instance.private_endpoint_instance.id}"
# }
