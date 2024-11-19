# Docker Volume for Apache2 Web Application

This guide will help you create a Docker volume and mount it to an Apache2 container to store web application data in `/var/www/html`.

## Prerequisites
- Docker installed on your machine.
- Basic understanding of Docker commands and container management.

## Steps to Create a Docker Volume and Mount It

1. **Create a Docker Volume**
   
   First, let's create a new volume named `web_data` to store the web application data:
   ```sh
   docker volume create web_data
   ```

2. **Run an Apache2 Container with the Volume Mounted**
   
   Now, run an Apache2 container and mount the volume to `/var/www/html` to store the web data:
   ```sh
   docker run -d \
     --name apache_container \
     -p 8080:80 \
     -v web_data:/var/www/html \
     httpd:latest
   ```

   - `-d`: Run the container in detached mode.
   - `--name apache_container`: Name of the container.
   - `-p 8080:80`: Map port 8080 of your local machine to port 80 of the container.
   - `-v web_data:/var/www/html`: Mount the `web_data` volume to `/var/www/html` inside the container.
