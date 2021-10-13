# RPM package builder
To build a RPM package manually 

# Dependencies
> OS: CentOS Linux 7+, Fedora, Rhel7, Amzn Linux

# Steps
1. Copy nginx-module-vts.spec,init.sh file into /root/
2. Run 
   ``` sh
   cd /root/
   chmod +x init.sh
   ./init.sh
   ```
 ### How to Test
 1. Add following entry into /etc/nginx/nginx.conf
 ```sh
 #load modules
 load_module modules/ngx_http_vhost_traffic_status_module.so;
 http {
     vhost_traffic_status_zone;
 }
 ```
 2. Add following entry into /etc/nginx/conf.d/default.conf
 ```sh
 server {
     location /status {
              vhost_traffic_status_display;
              vhost_traffic_status_display_format prometheus;
     }
 }
 ```
 4. Restart Nginx
 ```sh
 nginx -t
 systemctl restart nginx
 ```
 3. Test using curl
 ```sh
 curl http://localhost/status
 ```
