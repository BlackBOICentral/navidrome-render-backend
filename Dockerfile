FROM deluan/navidrome:latest

# Switch to root user to install software dependencies 
USER root

# Clean install system packages and the rclone binary distribution
RUN apk add --no-cache bash curl fuse3 && \
    curl https://rclone.org/install.sh | bash

# Copy the background orchestration shell script into the container root
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Change ownership of standard data directories to prevent permissions locks
RUN mkdir -p /data/music /data/cache && chmod -R 777 /data

# Direct the container runtime to use our background runner file
ENTRYPOINT ["/run.sh"]
