# CLI Commands for Docker Secret for MySQL Credentials

This guide provides CLI commands to create Docker secrets for storing MySQL database credentials (username and password). These secrets will be used to securely connect your web application to the MySQL database.

1. Enable Docker Swarm:
   ```sh
   docker swarm init
   ```

2. Create MySQL username secret:
   ```sh
   echo "your_mysql_username" | docker secret create mysql_username -
   ```

3. Create MySQL password secret:
   ```sh
   echo "your_mysql_password" | docker secret create mysql_password -
   ```

4. Deploy the service:
   ```sh
   docker service create \
     --name webapp \
     --secret mysql_username \
     --secret mysql_password \
     --env MYSQL_USER_FILE="/run/secrets/mysql_username" \
     --env MYSQL_PASSWORD_FILE="/run/secrets/mysql_password" \
     -p 8080:8080 \
     backend
   ```