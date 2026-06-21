#!/bin/bash

# 1. Create directory for the rclone system config file
mkdir -p ~/.config/rclone/

# 2. Write the S3-API details to rclone dynamically using Render Environment variables
cat <<EOF > ~/.config/rclone/rclone.conf
[supabase]
type = s3
provider = Other
access_key_id = $qxzhrmpijtsmovcodmzr
secret_access_key = $sb_secret_GDMbj6xF4wv16KmUUXHPvA_UlXQBpdg
endpoint = https://$qxzhrmpijtsmovcodmzr.supabase.co/storage/v1/s3
region = us-east-1
EOF

# 3. Mount the Supabase public bucket 'music' to our local filesystem folder
# --allow-other and --vfs-cache-mode allow Navidrome to read files smoothly over HTTP
echo "--> Mounting Supabase Storage via Rclone FUSE..."
rclone mount supabase:music /data/music --allow-other --vfs-cache-mode full --dir-cache-time 10s &

# 4. Give the background mount daemon 5 seconds to establish connection before Navidrome starts
sleep 5

# 5. Hand over ultimate process control to the core Navidrome application binary
echo "--> Starting Navidrome Engine..."
exec /app/navidrome
