#==================== Setting up stage ====================#

# Create image based on the official nginx - Alpine image
FROM nginx:1.16.0-alpine

# Remove any existing config files
RUN rm /etc/nginx/conf.d/*

# Copy config files
# *.conf files in conf.d/ dir get included in main config
COPY ./config/web/default.conf /etc/nginx/conf.d/

# Expose the listening port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]