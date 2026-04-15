# EC2 Setup

This guide shows how to launch EC2 instances, attach IAM roles, install Nginx, and place the instances behind an Application Load Balancer.

## Prerequisites

Before you start, make sure these already exist:

- VPC and subnets
- Security groups
- IAM role for EC2

## Step 1: Open EC2

1. Search for `EC2` in the AWS search bar.
2. Click `EC2`.
3. On the EC2 dashboard, click `Instances` in the left sidebar.
4. Click `Launch instances`.

## Step 2: Configure the Instance

1. In `Name and tags`, enter `startup-web-1`.
2. In `Application and OS Images`, choose `Amazon Linux 2023` or `Ubuntu`.
3. In `Instance type`, select `t2.micro` or `t3.micro` if eligible.
4. In `Key pair`, select an existing key pair or click `Create new key pair`.
5. Download the key pair and store it safely if you plan to use SSH.

## Step 3: Choose Network Settings

1. In the `Network settings` section, click `Edit`.
2. VPC: choose `startup-prod-vpc`.
3. Subnet: choose a private application subnet such as `startup-private-app-a`.
4. Auto-assign public IP: choose `Disable`.
5. Firewall security group: choose `Select existing security group`.
6. Select `startup-web-sg`.

## Step 4: Attach IAM Role

If the launch screen allows it:

1. Expand `Advanced details`.
2. Find `IAM instance profile`.
3. Select `startup-app-role`.

If the instance is already created:

1. Select the instance from the EC2 list.
2. Click `Actions`.
3. Click `Security`.
4. Click `Modify IAM role`.
5. Select `startup-app-role`.
6. Click `Update IAM role`.

## Step 5: Add User Data

1. On the launch screen, expand `Advanced details`.
2. Scroll to `User data`.
3. Paste the contents of `scripts/user-data.sh`.
4. Launch the instance.

## Step 6: Verify the Instance

1. Wait until the instance state becomes `Running`.
2. Click the instance ID.
3. Open the `Details` tab.
4. Confirm it is in the correct VPC, subnet, and security group.

## Step 7: Create a Target Group

1. In the left sidebar under `Load Balancing`, click `Target Groups`.
2. Click `Create target group`.
3. Choose `Instances`.
4. Click `Next`.
5. Target group name: `startup-web-tg`.
6. Protocol: `HTTP`
7. Port: `80`
8. VPC: `startup-prod-vpc`
9. Click `Next`.
10. Select your instance.
11. Click `Include as pending below`.
12. Click `Create target group`.

## Step 8: Create an Application Load Balancer

1. In the left sidebar, click `Load Balancers`.
2. Click `Create Load Balancer`.
3. Under `Application Load Balancer`, click `Create`.
4. Name: `startup-alb`
5. Scheme: `Internet-facing`
6. IP address type: `IPv4`
7. Network mapping:
   - VPC: `startup-prod-vpc`
   - Availability Zones: choose the two public subnets
8. Security groups: select `startup-alb-sg`
9. Listener: `HTTP:80`
10. Default action: forward to `startup-web-tg`
11. Click `Create load balancer`

## Step 9: Test the Load Balancer

1. Open the ALB details page.
2. Copy the `DNS name`.
3. Paste it into a browser.
4. You should see the Nginx default page or your application page.

## Optional: Create an Auto Scaling Group

1. In the EC2 left menu, click `Launch Templates`.
2. Create a launch template using the same AMI, security group, IAM role, and user data.
3. Then click `Auto Scaling Groups`.
4. Click `Create Auto Scaling group`.
5. Name it `startup-web-asg`.
6. Choose the launch template.
7. Select the private application subnets.
8. Attach it to `startup-web-tg`.
9. Set desired, minimum, and maximum capacity values.
10. Add scaling policies based on CPU utilization if required.

