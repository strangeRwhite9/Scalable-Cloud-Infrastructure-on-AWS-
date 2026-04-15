# Step-by-Step Deployment

This is the main deployment guide for reproducing the project from the AWS Console.

## Phase 1: Prepare the AWS Account

1. Sign in to AWS and choose the region you want to use.
2. Search for `IAM`.
3. Create an admin group and user.
4. Enable MFA on the user.
5. Create the EC2 IAM role.

Reference: see `configurations/iam-setup.md`.

## Phase 2: Build the Network

1. Search for `VPC`.
2. Create the custom VPC.
3. Create public and private subnets.
4. Attach an Internet Gateway.
5. Allocate an Elastic IP.
6. Create a NAT Gateway.
7. Create public and private route tables.
8. Associate the correct subnets to the correct route tables.

Reference: see `configurations/vpc-setup.md`.

## Phase 3: Create Security Boundaries

1. Search for `EC2`.
2. Open `Security Groups`.
3. Create:
   - `startup-alb-sg`
   - `startup-web-sg`
   - `startup-rds-sg`
4. Confirm only the ALB security group is public-facing.

Reference: see `configurations/security-groups.md`.

## Phase 4: Launch the Application Tier

1. Open `EC2`.
2. Click `Launch instances`.
3. Choose Linux AMI and instance type.
4. Place the instance in a private application subnet.
5. Disable public IP.
6. Attach `startup-web-sg`.
7. Attach `startup-app-role`.
8. Paste the user data script from `scripts/user-data.sh`.
9. Launch the instance.

Reference: see `configurations/ec2-setup.md`.

## Phase 5: Create the Load Balancer

1. In EC2, click `Target Groups`.
2. Create `startup-web-tg`.
3. Register the EC2 instance.
4. Click `Load Balancers`.
5. Create an internet-facing `Application Load Balancer`.
6. Attach the public subnets.
7. Attach `startup-alb-sg`.
8. Forward traffic to `startup-web-tg`.
9. Wait until the target health is `healthy`.

## Phase 6: Create the Database Tier

1. Search for `RDS`.
2. Click `Create database`.
3. Choose the engine.
4. Put the DB into the private DB subnets.
5. Set public access to `No`.
6. Attach `startup-rds-sg`.
7. Enable backups and Multi-AZ if your budget allows it.

Reference: see `configurations/rds-setup.md`.

## Phase 7: Add Storage

1. Search for `S3`.
2. Create a bucket.
3. Enable versioning.
4. Enable encryption.
5. Add lifecycle rules.
6. Restrict access with IAM.

Reference: see `configurations/s3-setup.md`.

## Phase 8: Add Monitoring

1. Search for `CloudWatch`.
2. Create CPU, health, and storage alarms.
3. Build a dashboard with key metrics.
4. Search for `CloudTrail`.
5. Create a trail for API audit logging.

Reference: see files in `monitoring/`.

## Phase 9: Validate the Deployment

1. Open the ALB DNS name in a browser.
2. Confirm the Nginx page loads.
3. Confirm the target group shows healthy instances.
4. Confirm the EC2 instance has no public IP.
5. Confirm the database is private.
6. Confirm alarms are active.

## Phase 10: Capture Proof for GitHub

Take screenshots from:

- VPC
- Subnets
- EC2 instances
- Load Balancer
- RDS
- S3
- IAM roles
- CloudWatch dashboard

Then place them in the `screenshots/` directory using the required names.

## Optional Service Extensions

If you want to make the project look stronger on GitHub, you can add:

- DynamoDB for NoSQL use cases
- Lambda for automation jobs
- SNS for notifications
- SQS for decoupled background processing

These are optional, but mentioning them in your README can show broader AWS familiarity if you actually configured them.
