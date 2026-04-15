# VPC Setup

This guide shows the AWS Console clicks for creating the network layer.

## Goal

Create:

- 1 custom VPC
- 2 public subnets
- 2 private application subnets
- 2 private database subnets
- 1 Internet Gateway
- 1 NAT Gateway
- Route tables for public and private traffic

## Step 1: Open VPC Dashboard

1. Sign in to the AWS Management Console.
2. In the top search bar, type `VPC`.
3. Click `VPC` under Services.
4. In the left sidebar, click `Your VPCs`.
5. Click the orange `Create VPC` button.

## Step 2: Create the VPC

1. Under `Resources to create`, select `VPC only`.
2. In `Name tag`, enter `startup-prod-vpc`.
3. In `IPv4 CIDR`, enter `10.0.0.0/16`.
4. Leave IPv6 disabled unless your project needs it.
5. Leave tenancy as `Default`.
6. Click `Create VPC`.
7. You should see a success banner and your VPC listed in the table.

## Step 3: Create Public Subnets

1. In the left sidebar, click `Subnets`.
2. Click `Create subnet`.
3. Under `VPC ID`, choose `startup-prod-vpc`.
4. For the first subnet:
   - Subnet name: `startup-public-subnet-a`
   - Availability Zone: choose one zone such as `us-east-1a`
   - IPv4 CIDR block: `10.0.1.0/24`
5. Click `Add new subnet`.
6. For the second subnet:
   - Subnet name: `startup-public-subnet-b`
   - Availability Zone: choose a second zone such as `us-east-1b`
   - IPv4 CIDR block: `10.0.2.0/24`
7. Click `Create subnet`.

## Step 4: Create Private Application Subnets

1. Stay on the `Create subnet` flow or return to `Subnets` and click `Create subnet`.
2. Choose the same VPC.
3. Add:
   - `startup-private-app-a` with `10.0.11.0/24`
   - `startup-private-app-b` with `10.0.12.0/24`
4. Place them in different Availability Zones.
5. Click `Create subnet`.

## Step 5: Create Private Database Subnets

1. Click `Create subnet` again.
2. Choose the same VPC.
3. Add:
   - `startup-private-db-a` with `10.0.21.0/24`
   - `startup-private-db-b` with `10.0.22.0/24`
4. Put them in different Availability Zones.
5. Click `Create subnet`.

## Step 6: Create and Attach Internet Gateway

1. In the left sidebar, click `Internet gateways`.
2. Click `Create internet gateway`.
3. Name it `startup-igw`.
4. Click `Create internet gateway`.
5. On the next page, click `Actions`.
6. Click `Attach to VPC`.
7. Select `startup-prod-vpc`.
8. Click `Attach internet gateway`.

## Step 7: Create a Public Route Table

1. In the left sidebar, click `Route tables`.
2. Click `Create route table`.
3. Name it `startup-public-rt`.
4. Choose `startup-prod-vpc`.
5. Click `Create route table`.
6. Open the new route table.
7. Click the `Routes` tab.
8. Click `Edit routes`.
9. Click `Add route`.
10. Destination: `0.0.0.0/0`
11. Target: choose `Internet Gateway`, then select `startup-igw`.
12. Click `Save changes`.

## Step 8: Associate Public Subnets

1. Open `startup-public-rt`.
2. Click the `Subnet associations` tab.
3. Click `Edit subnet associations`.
4. Check `startup-public-subnet-a`.
5. Check `startup-public-subnet-b`.
6. Click `Save associations`.

## Step 9: Allocate an Elastic IP for NAT

1. In the left sidebar, click `Elastic IPs`.
2. Click `Allocate Elastic IP address`.
3. Leave the default Amazon pool selected.
4. Click `Allocate`.

## Step 10: Create a NAT Gateway

1. In the left sidebar, click `NAT gateways`.
2. Click `Create NAT gateway`.
3. Name it `startup-nat-a`.
4. Select `startup-public-subnet-a`.
5. Under `Elastic IP allocation ID`, choose the Elastic IP you just allocated.
6. Click `Create NAT gateway`.
7. Wait until the status changes to `Available`.

## Step 11: Create a Private Route Table

1. Click `Route tables`.
2. Click `Create route table`.
3. Name it `startup-private-rt`.
4. Choose `startup-prod-vpc`.
5. Click `Create route table`.
6. Open it, then go to the `Routes` tab.
7. Click `Edit routes`.
8. Add route `0.0.0.0/0`.
9. For target, choose `NAT Gateway`.
10. Select `startup-nat-a`.
11. Click `Save changes`.

## Step 12: Associate Private Subnets

1. Open `startup-private-rt`.
2. Click `Subnet associations`.
3. Click `Edit subnet associations`.
4. Check:
   - `startup-private-app-a`
   - `startup-private-app-b`
   - `startup-private-db-a`
   - `startup-private-db-b`
5. Click `Save associations`.

## Step 13: Enable Auto-Assign Public IP for Public Subnets

1. Go back to `Subnets`.
2. Select `startup-public-subnet-a`.
3. Click `Actions`.
4. Click `Edit subnet settings`.
5. Check `Enable auto-assign public IPv4 address`.
6. Click `Save`.
7. Repeat for `startup-public-subnet-b`.

## What You Should See

- One VPC with CIDR `10.0.0.0/16`
- Two public subnets
- Four private subnets
- One attached Internet Gateway
- One available NAT Gateway
- One public route table using the IGW
- One private route table using the NAT Gateway


