# Use nginx base image
FROM nginx:alpine

# Remove default nginx website  
RUN rm -rf /usr/share/nginx/html/*

# Copy ALL files 
COPY . /usr/share/nginx/html/

# Change nginx to listen on port 8080
RUN sed -i 's/listen       80;/listen       8080;/g' /etc/nginx/conf.d/default.conf

# Expose port 8080
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]


