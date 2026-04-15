#!/usr/bin/env bash
set -euo pipefail

if command -v dnf >/dev/null 2>&1; then
  sudo dnf update -y
  sudo dnf install -y nginx
elif command -v yum >/dev/null 2>&1; then
  sudo yum update -y
  sudo amazon-linux-extras install -y nginx1 || true
  sudo yum install -y nginx
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y nginx
else
  echo "No supported package manager found."
  exit 1
fi

sudo systemctl enable nginx
sudo systemctl start nginx

cat <<'EOF' | sudo tee /usr/share/nginx/html/index.html >/dev/null
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AWS Cloud Infrastructure Project</title>
</head>
<body>
  <h1>AWS 3-Tier Infrastructure Is Running</h1>
  <p>This page is served from an EC2 instance behind an Application Load Balancer.</p>
</body>
</html>
EOF

sudo systemctl restart nginx
echo "Nginx installed and started successfully."
