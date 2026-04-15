# Logging Setup

This file documents the logging stack for the project.

## CloudWatch Logs

Use CloudWatch Logs to centralize:

- Nginx access logs
- Nginx error logs
- Application logs
- System logs

## CloudTrail

Use CloudTrail for governance and auditing:

- API activity history
- IAM changes
- Console logins
- Resource creation and deletion events

## EC2 Log Shipping Flow

1. Attach the `CloudWatchAgentServerPolicy` policy to the EC2 IAM role.
2. Install the CloudWatch agent on the EC2 instance.
3. Create the CloudWatch agent configuration file.
4. Start the CloudWatch agent service.

## Console Steps for CloudTrail

1. Search for `CloudTrail`.
2. Click `CloudTrail`.
3. In the left sidebar, click `Trails`.
4. Click `Create trail`.
5. Trail name: `startup-audit-trail`.
6. Choose whether to create a new S3 bucket or use an existing one.
7. Leave multi-region enabled if you want full account coverage.
8. Click `Next`.
9. Review settings.
10. Click `Create trail`.

## What to Document in GitHub

- Which logs are collected from EC2
- Where CloudTrail stores audit data
- Which alarm notifications are enabled
- Which metrics are most important to your application
