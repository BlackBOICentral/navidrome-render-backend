FROM deluan/navidrome:latest

# Switch to root to add the tools
USER root

# Clean install alpine native rclone and bash packages directly
RUN apk add --no-cache bash rclone

# Copy the background orchestration shell script into the container root
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set up our working paths
RUN mkdir -p /data/music /data/cache && chmod -R 777 /data

# Direct the container runtime to use our background runner file
ENTRYPOINT ["/run.sh"]
