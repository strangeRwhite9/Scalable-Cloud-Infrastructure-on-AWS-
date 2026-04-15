# Security Groups

This file documents the recommended security group layout for the project.

## Goal

Restrict traffic so that:

- The internet can only reach the Load Balancer
- The Load Balancer can reach the web servers
- The web servers can reach the database
- Administrative access is controlled

## Security Group Design

### 1. Load Balancer Security Group

Name: `startup-alb-sg`

Inbound rules:

- HTTP, port `80`, source `0.0.0.0/0`
- HTTPS, port `443`, source `0.0.0.0/0` if TLS is configured

Outbound rules:

- Allow all outbound, or at minimum allow traffic to the web server security group

### 2. Web Server Security Group

Name: `startup-web-sg`

Inbound rules:

- HTTP, port `80`, source `startup-alb-sg`
- HTTPS, port `443`, source `startup-alb-sg` if your app uses TLS internally
- SSH, port `22`, source your admin IP or bastion host security group

Outbound rules:

- MySQL or PostgreSQL to the database security group
- HTTPS `443` outbound for updates, package installs, and AWS API calls

### 3. Database Security Group

Name: `startup-rds-sg`

Inbound rules:

- MySQL `3306` from `startup-web-sg` for MySQL
- PostgreSQL `5432` from `startup-web-sg` for PostgreSQL

Outbound rules:

- Default outbound is acceptable unless your environment requires stricter control

## Click-by-Click Creation

1. Open the AWS Console.
2. Search for `EC2`.
3. Click `EC2`.
4. In the left menu, scroll to `Network & Security`.
5. Click `Security Groups`.
6. Click `Create security group`.

### Create `startup-alb-sg`

1. Security group name: `startup-alb-sg`
2. Description: `Allow internet traffic to the load balancer`
3. VPC: select `startup-prod-vpc`
4. Under `Inbound rules`, click `Add rule`
5. Type: `HTTP`
6. Source: `Anywhere-IPv4`
7. Add another rule if needed:
   - Type: `HTTPS`
   - Source: `Anywhere-IPv4`
8. Click `Create security group`

### Create `startup-web-sg`

1. Click `Create security group`
2. Name: `startup-web-sg`
3. Description: `Allow ALB traffic to web servers`
4. VPC: `startup-prod-vpc`
5. Under `Inbound rules`, add:
   - Type: `HTTP`
   - Source type: `Custom`
   - Source: choose `startup-alb-sg`
6. Add SSH only if you need direct access:
   - Type: `SSH`
   - Source: `My IP`
7. Click `Create security group`

### Create `startup-rds-sg`

1. Click `Create security group`
2. Name: `startup-rds-sg`
3. Description: `Allow app servers to reach RDS`
4. VPC: `startup-prod-vpc`
5. Add inbound rule:
   - Type: `MYSQL/Aurora` or `PostgreSQL`
   - Source: `startup-web-sg`
6. Click `Create security group`

## Validation

- The ALB security group should be the only one open to the public internet.
- The web server security group should not allow HTTP from `0.0.0.0/0`.
- The RDS security group should only allow the application tier.

