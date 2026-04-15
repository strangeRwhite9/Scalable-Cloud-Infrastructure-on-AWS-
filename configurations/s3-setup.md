# S3 Setup

This guide shows how to create a secure S3 bucket for static files, backups, or exported logs.

## Step 1: Open S3

1. Search for `S3` in the AWS search bar.
2. Click `S3`.
3. Click `Create bucket`.

## Step 2: Create the Bucket

1. Bucket name: choose a globally unique name such as `startup-cloud-assets-yourname`.
2. Region: choose the same region as the rest of the project.
3. Leave `Block all public access` enabled unless you explicitly need a public website bucket.
4. Bucket versioning: `Enable`
5. Default encryption: choose `Server-side encryption with AWS Key Management Service key (SSE-KMS)` or `SSE-S3`
6. Click `Create bucket`

## Step 3: Configure Versioning

1. Open the bucket.
2. Click the `Properties` tab.
3. Scroll to `Bucket Versioning`.
4. Click `Edit`.
5. Make sure versioning is `Enable`.
6. Click `Save changes`.

## Step 4: Configure Encryption

1. Stay on `Properties`.
2. Scroll to `Default encryption`.
3. Click `Edit`.
4. Choose SSE-KMS if you want stronger key management controls.
5. Choose the AWS managed key or your customer managed key.
6. Click `Save changes`.

## Step 5: Create a Lifecycle Rule

1. On the same bucket, click the `Management` tab.
2. Click `Create lifecycle rule`.
3. Name: `archive-old-logs`
4. Apply to all objects or to a prefix such as `logs/`
5. Choose a transition action, for example move older objects to lower-cost storage after a set number of days.
6. If needed, add expiration settings.
7. Review and click `Create rule`.

## Step 6: Restrict Bucket Access

1. Click the `Permissions` tab.
2. Review `Bucket policy`.
3. Do not allow `Principal: *` unless this is intentionally public.
4. If your EC2 app needs access, grant permissions through the IAM role instead of using public access.

## Step 7: Upload a Test File

1. Click the `Objects` tab.
2. Click `Upload`.
3. Add a small test file.
4. Click `Upload`.
5. Confirm the file appears in the bucket.

