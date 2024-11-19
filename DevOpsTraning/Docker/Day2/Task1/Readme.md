# Docker Setup for MySQL with Persistent Storage

## Overview
This guide provides instructions for setting up a MySQL container using Docker, including creating and mounting a Docker volume for persistent storage of MySQL data. The volume ensures that your database data remains safe even if the container stops or is removed.

## Steps

### Step 1: Create a Docker Volume


Run the following command to create a Docker volume named `mysql_data`:

```bash
$ docker volume create mysql_data
```

### Step 2: Run the MySQL Container with the Mounted Volume
To set up the MySQL container, mount the `mysql_data` volume to the MySQL data directory (`/var/lib/mysql`). This ensures the data persists.

Use the following command to run the container:

```bash
$ docker run -d \
  --name mysql_container \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:latest
```