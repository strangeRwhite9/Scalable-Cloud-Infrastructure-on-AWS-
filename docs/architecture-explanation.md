# Architecture Explanation

This project uses a layered AWS architecture to improve scalability, security, and operational clarity.

## 1. Presentation Layer

The presentation layer is the entry point for user traffic. An Application Load Balancer sits in public subnets so it can accept internet requests. This layer is intentionally the only tier exposed to the public internet.

Why it matters:

- It distributes traffic across healthy targets
- It improves availability
- It prevents direct public access to EC2 application servers

## 2. Application Layer

The application layer runs on EC2 instances placed in private subnets. These instances process requests forwarded by the ALB and can be scaled manually or automatically.

Why it matters:

- Private placement reduces exposure
- Auto Scaling can improve fault tolerance and cost efficiency
- IAM roles give applications AWS access without hard-coded credentials

## 3. Data Layer

The data layer stores persistent data in Amazon RDS. Keeping the database in private subnets prevents direct internet access and reduces attack surface.

Why it matters:

- RDS offloads patching and backups compared to self-managed databases
- Multi-AZ can improve resilience
- Security groups restrict access to only the application layer

## Supporting Services

### S3

Used for:

- Static assets
- Backups
- Log archives

### IAM

Used for:

- User and group access control
- EC2 instance roles
- Least-privilege policy enforcement

### CloudWatch

Used for:

- Metrics
- Dashboards
- Alarms
- Log collection

### CloudTrail

Used for:

- Governance
- Security auditing
- Change tracking

## Request Path

1. User reaches the public ALB endpoint.
2. ALB forwards traffic to healthy EC2 targets in private subnets.
3. EC2 processes application logic.
4. The application reads or writes data to RDS.
5. Logs and metrics go to CloudWatch.

## Security Design

- Only the ALB is public
- EC2 stays private
- RDS stays private
- Security groups control east-west and north-south traffic
- IAM roles remove the need for hard-coded AWS keys
- MFA protects privileged access

## High Availability Design

- Public and private resources are spread across multiple Availability Zones
- ALB routes around unhealthy instances
- Multi-AZ RDS can improve database resilience
- Auto Scaling can replace failed instances and respond to demand

## Cost Control Notes

- Small instance sizes help for demos and student projects
- Lifecycle rules lower S3 storage cost
- Auto Scaling avoids overprovisioning
- NAT Gateways and Multi-AZ should be justified because they increase cost
