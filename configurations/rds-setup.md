# RDS Setup

This guide shows how to create a managed relational database in private subnets.

## Step 1: Open RDS

1. Search for `RDS` in the AWS search bar.
2. Click `RDS`.
3. In the left sidebar, click `Databases`.
4. Click `Create database`.

## Step 2: Choose Database Creation Method

1. Select `Standard create`.
2. Choose an engine such as `MySQL` or `PostgreSQL`.
3. Select the desired engine version.

## Step 3: Configure the Database

1. Under `Templates`, choose `Free tier` for a small demo or `Dev/Test` for more control.
2. DB instance identifier: `startup-db`
3. Master username: choose a username
4. Master password: create and confirm a strong password

## Step 4: Configure Instance Size and Storage

1. For class, choose a small instance appropriate for your project.
2. Configure storage size.
3. Enable storage autoscaling if appropriate.

## Step 5: Network and Security

1. Scroll to `Connectivity`.
2. VPC: `startup-prod-vpc`
3. Create or choose a DB subnet group that uses:
   - `startup-private-db-a`
   - `startup-private-db-b`
4. Public access: `No`
5. VPC security group: choose `startup-rds-sg`
6. Availability Zone: let AWS choose or pick one for single-AZ setups

## Step 6: Availability and Protection

1. For stronger resilience, enable `Multi-AZ deployment`.
2. If the environment is a demo and cost matters more, you can leave Multi-AZ disabled.
3. Enable automated backups.
4. Keep deletion protection enabled if you do not want accidental removal.

## Step 7: Finalize

1. Expand `Additional configuration` if you want to set DB name, backup retention, logs export, or maintenance windows.
2. Click `Create database`.
3. Wait until the status becomes `Available`.

## Step 8: Verify Connectivity

1. Open the DB instance details page.
2. Confirm `Publicly accessible` shows `No`.
3. Copy the endpoint only for application configuration; do not expose it in public screenshots if you want to be cautious.
4. Ensure the EC2 application security group is allowed in `startup-rds-sg`.


