# Architecture Assets

Add your architecture images in this folder using these exact names:
<a href="https://app.eraser.io/workspace/mKxVubWHhg0SCqoWzhvZ?elements=mNk7FpFdoi-BHeHXbTbuOg">View on Eraser<br /><img src="https://app.eraser.io/workspace/mKxVubWHhg0SCqoWzhvZ/preview?elements=mNk7FpFdoi-BHeHXbTbuOg&type=embed" /></a>

- `architecture-diagram.png`
- `request-flow.png`

Suggested exports:

- A full 3-tier architecture diagram from draw.io, Lucidchart, or Excalidraw
- A request flow diagram showing User -> ALB -> EC2 -> RDS/S3 -> CloudWatch

What to include in `architecture-diagram.png`:

- VPC boundary
- Two Availability Zones
- Public subnets
- Private application subnets
- Private database subnets
- Internet Gateway
- NAT Gateway
- Application Load Balancer
- EC2 instances or Auto Scaling Group
- RDS instance or Multi-AZ deployment
- S3 bucket
- CloudWatch and CloudTrail

What to include in `request-flow.png`:

1. User request enters ALB over HTTP or HTTPS.
2. ALB forwards traffic to healthy EC2 targets.
3. Application reads or writes data to RDS.
4. Files or backups are stored in S3.
5. Metrics and logs go to CloudWatch.
