# Use lightweight nginx image
FROM nginx:alpine

# Copy frontend files to nginx html directory
COPY . /usr/share/nginx/html

# Expose port 8080 (Cloud Run expects 8080)
EXPOSE 8080

# Change Nginx config to use port 8080
RUN sed -i 's/listen       80;/listen 8080;/g' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
