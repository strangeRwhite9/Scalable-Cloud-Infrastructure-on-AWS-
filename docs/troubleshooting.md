# Troubleshooting

This file lists common problems and how to fix them.

## Problem: ALB DNS Name Does Not Load

Check:

- The ALB is `internet-facing`
- The ALB is in public subnets
- The public route table points to the Internet Gateway
- The ALB security group allows port `80` or `443`
- The target group has healthy instances

## Problem: Targets Stay Unhealthy

Check:

- The EC2 instance is running
- Nginx is installed and started
- The web server security group allows traffic from the ALB security group
- The target group health check path is correct
- The application is listening on the expected port

## Problem: Cannot Reach the Database

Check:

- RDS is in private subnets
- The RDS security group allows traffic from `startup-web-sg`
- The application is using the correct DB endpoint, port, username, and password
- Network ACLs are not blocking traffic

## Problem: EC2 Cannot Install Packages

Check:

- The instance is in a private subnet with a route to the NAT Gateway
- The NAT Gateway is in a public subnet
- The public subnet route table points to the Internet Gateway
- The instance can resolve DNS

## Problem: Cannot SSH to EC2

Check:

- SSH is actually needed; SSM is often better
- Port `22` is open from your IP in `startup-web-sg`
- The instance has a reachable path if you are not using a bastion or Session Manager
- The correct key pair is being used

## Problem: S3 Access Denied

Check:

- The EC2 IAM role includes the correct S3 permissions
- The bucket policy does not explicitly deny access
- The bucket name in the application config is correct
- KMS permissions are present if SSE-KMS is enabled

## Problem: No CloudWatch Metrics or Logs

Check:

- The CloudWatch agent policy is attached to the EC2 role
- The CloudWatch agent is installed and running
- The correct region is selected in the Console
- Alarm dimensions match the correct instance, ALB, or DB

## Problem: Costs Are Higher Than Expected

Check:

- NAT Gateway runtime cost
- Multi-AZ RDS cost
- Unused Elastic IPs
- Oversized EC2 or RDS instances
- S3 lifecycle policy settings
