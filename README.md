# SSM Practice Lab

A hands-on Terraform lab for learning how AWS Systems Manager (SSM) Session Manager works and how to configure it correctly — for both public and private EC2 instances.

## Goal

Practice configuring SSM Session Manager access to EC2 instances without relying on SSH key pairs, bastion hosts, or open inbound ports. This lab intentionally uses the **default VPC** to avoid spending time on custom networking and keep the focus on SSM itself.

## Status

| Component                            | Status         |
| ------------------------------------ | -------------- |
| Public subnet instance + SSM         | ✅ Done        |
| Private subnet + SSM (NAT Gateway)   | ✅ Done        |
| Private subnet + SSM (VPC Endpoints) | 🚧 In progress |

## What's done: public instance SSM access

- EC2 instance launched in the default VPC's public subnet, with an IAM role/instance profile attached (`AmazonSSMManagedInstanceCore`)
- Security group scoped to outbound `443` only — SSM Session Manager and the SSM Agent only need HTTPS to the `ssm`, `ssmmessages`, and `ec2messages` endpoints; no inbound rules are needed for SSM to work

## What's done: private instance via NAT Gateway

- EC2 instance launched in a custom private subnet, with an IAM role/instance profile attached (`AmazonSSMManagedInstanceCore`)
- Route table configured to point `0.0.0.0/0` outbound traffic to a newly provisioned NAT Gateway and Elastic IP in the public subnet
- Security group scoped to outbound `443` only to reach the public SSM endpoints.

## What's left: private instance via VPC Endpoints

- Configure a separate private EC2 instance that connects to SSM securely over the internal AWS network using VPC interface endpoints (`ssm`, `ssmmessages`, and `ec2messages`) without needing any internet access.

## Notes

- Default VPC is used deliberately to keep the focus on SSM rather than VPC design.
