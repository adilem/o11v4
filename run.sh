#!/bin/bash

# Remove old /root/o11 entries from /etc/fstab
sed -i '/root\/o11/d' /etc/fstab
sleep 2

# Append new tmpfs entries to /etc/fstab
cat <<EOL >> /etc/fstab

tmpfs /root/o11/hls tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=70% 0 0
tmpfs /root/o11/dl tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=70% 0 0
EOL

# Mount all entries in /etc/fstab
mount -av

# Create directories if they don't exist
mkdir -p /root/o11/hls /root/o11/dl

# Infinite loop to check if o11 is running
while true; do
  if ! pgrep "o11v4" > /dev/null; then
    # Start the o11 process
    /root/o11/o11v4 -p 8484 -noramfs -f /usr/local/bin/ffmpeg -path "/root/o11/o11v4/" -noautostart -plstreamname "%s [%p]" &
    
    # Wait before checking again to give the process time to start
    sleep 10
  fi
  
  # Wait before checking again
  sleep 20
done
