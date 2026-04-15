#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y || true
yum install -y nginx
systemctl enable nginx
systemctl start nginx

cat <<'EOF' > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Startup AWS Project</title>
</head>
<body>
  <h1>Deployment Successful</h1>
  <p>This instance was configured using EC2 user data.</p>
</body>
</html>
EOF
