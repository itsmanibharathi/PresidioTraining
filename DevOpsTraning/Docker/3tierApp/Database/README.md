# Database Setup
To set up the MySQL database container, I ran the following command in the `database` folder:

```bash
docker run -d --name database -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=testdb -p 3306:3306 mysql:8
