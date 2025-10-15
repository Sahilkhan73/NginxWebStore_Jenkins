# Use the official NGINX image
FROM nginx:latest

# Copy your web store files to the NGINX HTML directory
COPY . /usr/share/nginx/html/

# Expose port 8080 (or any port you want)
EXPOSE 8080

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]

