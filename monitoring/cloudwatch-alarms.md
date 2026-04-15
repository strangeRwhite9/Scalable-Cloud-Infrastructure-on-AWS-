# CloudWatch Alarms

This guide documents the alarms that should be created for the AWS environment.

## Recommended Alarms

- EC2 CPU utilization too high
- ALB unhealthy host count above zero
- RDS CPU utilization too high
- RDS free storage space too low
- Status check failure on EC2

## Step 1: Open CloudWatch

1. Search for `CloudWatch` in AWS.
2. Click `CloudWatch`.
3. In the left sidebar, click `Alarms`.
4. Click `Create alarm`.

## Example Alarm: EC2 CPU Utilization

1. Click `Select metric`.
2. Click `EC2`.
3. Click `Per-Instance Metrics`.
4. Select the checkbox next to your instance's `CPUUtilization`.
5. Click `Select metric`.
6. Under `Statistic`, keep `Average`.
7. Under `Period`, choose `5 minutes`.
8. Under `Whenever CPUUtilization is`, choose `Greater` and enter `70`.
9. Click `Next`.
10. Choose an SNS topic if you already created one, or click `Create new topic`.
11. Enter an email address for alerts.
12. Click `Next`.
13. Alarm name: `startup-ec2-high-cpu`
14. Click `Next`.
15. Click `Create alarm`.

## Example Alarm: ALB Unhealthy Hosts

1. Click `Create alarm`.
2. Select metric.
3. Open `ApplicationELB`.
4. Choose the target group metric `UnHealthyHostCount`.
5. Set threshold `Greater than 0`.
6. Attach an SNS notification.
7. Name it `startup-alb-unhealthy-hosts`.
8. Create the alarm.

## Example Alarm: RDS CPU

1. Click `Create alarm`.
2. Select metric.
3. Open `RDS`.
4. Choose your DB instance metric `CPUUtilization`.
5. Set threshold based on your target, for example `Greater than 75`.
6. Add notifications.
7. Name it `startup-rds-high-cpu`.
8. Create the alarm.

## Dashboard Suggestion

Create a CloudWatch dashboard containing:

- EC2 CPU utilization
- Network in and out
- ALB request count
- ALB target response time
- RDS CPU and database connections


