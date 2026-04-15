# IAM Setup

This guide documents how to create IAM users, groups, roles, and MFA.

## Goal

Apply least privilege so administrators and EC2 instances only receive the permissions they actually need.

## Step 1: Open IAM

1. Sign in to AWS.
2. Search for `IAM` in the top search bar.
3. Click `IAM`.
4. In the left sidebar, you will see sections such as `Users`, `User groups`, `Roles`, and `Policies`.

## Step 2: Create an Admin Group

1. Click `User groups` on the left.
2. Click `Create group`.
3. Group name: `CloudAdmins`
4. Under `Attach permissions policies`, search for `AdministratorAccess`.
5. Check the box next to `AdministratorAccess`.
6. Click `Create user group`.

## Step 3: Create an IAM User

1. Click `Users`.
2. Click `Create user`.
3. User name: enter your preferred admin name, for example `student-admin`.
4. Click `Next`.
5. Under permissions options, choose `Add user to group`.
6. Check `CloudAdmins`.
7. Click `Next`.
8. Review the settings.
9. Click `Create user`.

## Step 4: Enable MFA for the User

1. Click the username you created.
2. Open the `Security credentials` tab.
3. Scroll to `Multi-factor authentication (MFA)`.
4. Click `Assign MFA device`.
5. Choose `Authenticator app`.
6. Click `Next`.
7. Scan the QR code with Google Authenticator, Microsoft Authenticator, or another MFA app.
8. Enter two consecutive generated codes.
9. Click `Add MFA`.

## Step 5: Create an EC2 Role

1. In the left sidebar, click `Roles`.
2. Click `Create role`.
3. Under trusted entity type, choose `AWS service`.
4. Under use case, click `EC2`.
5. Click `Next`.
6. Search for policies you need, for example:
   - `AmazonSSMManagedInstanceCore`
   - `CloudWatchAgentServerPolicy`
   - `AmazonS3ReadOnlyAccess` or a narrower custom policy
7. Check the policies.
8. Click `Next`.
9. Role name: `startup-app-role`
10. Click `Create role`.

## Step 6: Create a Custom S3 Policy if Needed

1. In the left menu, click `Policies`.
2. Click `Create policy`.
3. Click the `JSON` tab.
4. Paste a least-privilege policy that targets only your bucket.
5. Click `Next`.
6. Name the policy, for example `StartupAppS3Access`.
7. Click `Create policy`.
8. Return to `Roles`.
9. Open `startup-app-role`.
10. Click `Add permissions`.
11. Click `Attach policies`.
12. Search for `StartupAppS3Access`.
13. Check it and click `Add permissions`.

## What You Should See

- One admin group
- One IAM user in the admin group
- MFA enabled
- One EC2 role with only the permissions your app needs

