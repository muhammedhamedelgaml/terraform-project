user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log notice;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    server {
        listen 80;
        server_name _;

        # Serve static frontend files
        root /usr/share/nginx/html;
        index index.html;

   # Frontend app
    # All other routes
        location / {
        try_files $uri  /index.html;
            }


    #  Node.js API backend 
    location /api/ {
        proxy_pass http://${internal_alb_dns}:5000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

}