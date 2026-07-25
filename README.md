# SSM Practice Lab

A hands-on Terraform lab for learning how AWS Systems Manager (SSM) Session Manager works and how to configure it correctly — for both public and private EC2 instances.

## Goal

Practice configuring SSM Session Manager access to EC2 instances without relying on SSH key pairs, bastion hosts, or open inbound ports. This lab intentionally uses the **default VPC** to avoid spending time on custom networking and keep the focus on SSM itself.

## Status

| Component                    | Status         |
| ---------------------------- | -------------- |
| Public subnet instance + SSM | ✅ Done        |
| Private subnet + SSM         | 🚧 In progress |

## What's done: public instance SSM access

- EC2 instance launched in the default VPC's public subnet, with an IAM role/instance profile attached (`AmazonSSMManagedInstanceCore`)
- Security group scoped to outbound `443` only — SSM Session Manager and the SSM Agent only need HTTPS to the `ssm`, `ssmmessages`, and `ec2messages` endpoints; no inbound rules are needed for SSM to work

## What's left: private instance SSM access

The default VPC only ships with public subnets, so this part requires creating a custom private subnet by hand. Once that's in place, the private instance still needs a way to reach the SSM/ssmmessages/ec2messages endpoints without a route to the internet — the two options to try:

- **VPC interface endpoints** (PrivateLink) for `ssm`, `ssmmessages`, and `ec2messages`, each with its own security group allowing 443 inbound from the private instance's SG
- **NAT gateway** in the public subnet, routed from the private subnet's route table, so the instance can reach the public SSM endpoints the same way the public instance does

## Notes

- Default VPC is used deliberately to keep the focus on SSM rather than VPC design.
