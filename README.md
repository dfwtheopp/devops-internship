# DevOps Internship

This repository contains my DevOps internship work and learning exercises.

# Project Structure

* `day-1/` - Linux and Git practice
* `scripts/system-info.sh` - Displays basic system information
* `scripts/health-check.sh` - Checks the health of a website
* `logs/` - Stores health-check logs
* `notes/` - DevOps learning notes
* `networking/` - Networking notes

# System Information

Run:

`./scripts/system-info.sh`

# Day 4 - Bash Automation

# Cron Health Check

The health-check script is scheduled to run every 5 minutes.

Cron expression:

`*/5 * * * *`

The five fields represent:

1. Minute: `*/5` - every 5 minutes
2. Hour: `*` - every hour
3. Day of month: `*` - every day
4. Month: `*` - every month
5. Day of week: `*` - every day of the week

The scheduled job checks the local Nginx service using:

`http://localhost`

The output is appended to:

`logs/cron-health-check.log`

# Day 5 - Python for DevOps Automation

# Goal

Use Python to automate DevOps tasks that can become difficult to manage with Bash.

# Practice 1 - Multi-Service Monitor

Created `python/service_monitor.py`.

The script:

* Checks multiple URLs.
* Records HTTP status codes.
* Measures response time.
* Reports services as healthy or unhealthy.
* Records timestamps.
* Handles timeouts and connection errors.
* Saves the results to `reports/service-report.json`.

# Practice 2 - Log Analyzer

Created `python/log_analyzer.py`.

The script:

* Reads `logs/application.log`.
* Counts INFO, WARNING, and ERROR messages.
* Extracts ERROR entries.
* Generates a JSON summary.
* Saves the result to `reports/log-analysis-report.json`.

# Practice 3 - DevOps System Checker

Created `python/devops_check.py`.

The script checks:

* Disk usage
* Memory usage
* Hostname
* System uptime
* Nginx service status
* At least two URLs

The results are saved to:

`reports/system-report.json`

# Failure Testing

Three failure tests were performed:

1. Invalid URL

I tested a nonexistent website.

The program reported the connection/name-resolution problem without crashing.

2. Unavailable Service

I stopped Nginx.

The program detected that the service was inactive and reported the problem.

3. Invalid Input

I provided too many command-line arguments.

The program displayed a clear error message and usage instructions instead of producing an unreadable traceback.

After testing, the system was restored to its normal working state.

# Python Environment

A Python virtual environment was created using `.venv`.

The `requests` library was installed and recorded in `requirements.txt`.

The `.venv/` directory is excluded from Git using `.gitignore`.

# Docker Port Mapping

The port mapping `8080:80` means:

* 8080 is the host port.
* 80 is the container port.
* Traffic sent to port 8080 on the host is forwarded to port 80 inside the Docker container.

In this exercise, Nginx is listening on port 80 inside the container. Docker maps the host's port 8080 to that container port.

For example:

`docker run -d --name devops-nginx -p 8080:80 nginx`

# Day 6 - Docker Troubleshooting

# Failure 1 - Wrong Host Port

I first ran the container using the wrong host port:

`docker run -d --name devops-app-test -p 9000:8000 devops-app:v1`

When I tried:

`curl http://localhost:8000`

the connection failed.

I checked:

`docker ps -a`

`docker logs devops-app-test`

`docker inspect devops-app-test`

The application was running, but the port mapping was `9000:8000`.

The problem was that I was trying to access port 8000 on the host, but the container was mapped to port 9000.

I fixed it by using:

`curl http://localhost:9000`

The application then responded correctly.

# Failure 2 - Missing Environment Variable

I changed the application so that it needed an APP_NAME environment variable.

I then started the container without providing the variable:

`docker run -d --name devops-app-env-test -p 8000:8000 devops-app:v2`

When I tested it with:

`curl http://localhost:8000`

I got a 500 Internal Server Error.

I checked the logs:

`docker logs devops-app-env-test`

The error showed:

`KeyError: 'APP_NAME'`

The problem was that the application was trying to use APP_NAME, but the variable was not provided.

I fixed it by starting the container with:

`docker run -d --name devops-app-env-test -p 8000:8000 -e APP_NAME="My DevOps application" devops-app:v2`

After that, the application worked correctly.

# Failure 3 - App/Container Exits

I created another failure by telling Docker to run a Python file that did not exist:

`docker run --name devops-app-exit-test devops-app:v2 python wrong.py`

The container stopped immediately.

I checked it with:

`docker ps -a`

`docker logs devops-app-exit-test`

`docker inspect devops-app-exit-test`

The logs showed that `wrong.py` could not be found.

The problem was the incorrect command.

The correct command for the application is:

`python app.py`

After identifying the problem, I removed the failed container and understood that the container stopped because the command I gave Docker was incorrect.

# What I Learned

When a Docker container is not working, I can use `docker ps -a` to check its status, `docker logs` to see errors, and `docker inspect` to get more information about the container.

I also learned that port mappings and environment variables can affect whether an application works correctly inside a container.


# Practice 4 - Failure Investigation

# Incorrect Database Hostname

I changed the database hostname in docker-compose.yml from db to wrong-db to create a failure.

The application container still started because the Flask application does not currently connect to PostgreSQL when it starts.

# Investigation

I checked the containers using docker compose ps.

I checked the application logs using docker compose logs app.

I checked the database logs using docker compose logs db.

I inspected the application container using docker inspect devops-internship-app-1.

I then entered the application container and tested the hostname.

wrong-db did not resolve.

The correct hostname db resolved to the PostgreSQL container.

# Root Cause

The DB_HOST environment variable was set to wrong-db instead of db.

Docker Compose uses the service name db to allow the application container to find the PostgreSQL container on the Docker network.

# Fix

I changed DB_HOST back to db and recreated the containers using docker compose up -d.

The application started normally after the correct hostname was restored.

# Lesson Learned

Containers on the same Docker Compose network can communicate using the service name. localhost inside the application container refers to the application container itself, not the PostgreSQL container.
# Day 7 - Docker Compose

# Setup

The application and PostgreSQL database are run using Docker Compose.

Start the application and database:

docker compose up -d

Check the running containers:

docker compose ps

View the logs:

docker compose logs

Stop the containers:

docker compose down

The `.env` file contains the database configuration and is ignored by Git.

The `.env.example` file contains placeholder values showing which environment variables are required.

# Architecture

The application runs in one container and PostgreSQL runs in a separate container.

The application and database communicate through the Docker Compose network.

The application uses the service name `db` to find the PostgreSQL container.

PostgreSQL stores its database files in the named volume `postgres_data`.

Browser / curl → Application container → Docker network → PostgreSQL container → postgres_data volume

# Ports

The application runs on port 8000.

Port 8000 on the host is mapped to port 8000 inside the application container.

PostgreSQL uses port 5432 inside the Docker network.

The application uses `db:5432` to communicate with PostgreSQL.

The application health endpoint can be tested using:

curl http://localhost:8000/health

# Useful Commands

Start the containers:

docker compose up -d

Check container status:

docker compose ps

View all logs:

docker compose logs

View application logs:

docker compose logs app

View database logs:

docker compose logs db

Follow application logs:

docker compose logs -f app

List Docker networks:

docker network ls

Inspect the Compose network:

docker network inspect devops-internship_default

List Docker volumes:

docker volume ls

Enter the application container:

docker compose exec app sh

Enter PostgreSQL:

docker compose exec db psql -U marvin -d devops

Check the application health endpoint:

curl http://localhost:8000/health

Stop and remove the containers and network:

docker compose down

# Day 7 Troubleshooting

If the application cannot communicate with PostgreSQL, check the container status and logs first.

Useful commands:

docker compose ps

docker compose logs app

docker compose logs db

docker inspect devops-internship-app-1

docker network inspect devops-internship_default

The database hostname should be `db`.

The application should not use `localhost` to connect to PostgreSQL because `localhost` inside the application container refers to the application container itself.

# Day 7 Mini-Project

The application runs in a Docker container.

PostgreSQL runs in a separate Docker container.

The application and database communicate through a Docker network.

PostgreSQL data is stored using the named volume `postgres_data`.

The application has a `/health` endpoint.

Configuration uses environment variables.

The `.env` file is ignored by Git.

The `.env.example` file contains placeholder values.

A failure investigation was documented in the README.

# Day 7 Failure Investigation

The database hostname was intentionally changed from `db` to `wrong-db`.

The application container still started because the current Flask application does not connect to PostgreSQL when it starts.

The container status was checked using `docker compose ps`.

The application logs were checked using `docker compose logs app`.

The database logs were checked using `docker compose logs db`.

The application container was inspected using `docker inspect devops-internship-app-1`.

The hostname was tested from inside the application container.

`wrong-db` did not resolve.

The correct hostname `db` resolved to the PostgreSQL container.

# Root Cause

The `DB_HOST` environment variable was set to `wrong-db` instead of `db`.

Docker Compose uses the service name `db` to allow the application container to find the PostgreSQL container on the Docker network.

# Fix

The `DB_HOST` value was changed back to `db`.

The application container was recreated using:

docker compose up -d

The application started normally after the correct hostname was restored.

# Lesson Learned

Docker Compose provides service-name DNS.

Containers on the same Docker network can communicate using the service name.

`localhost` inside the application container refers to the application container itself, not the PostgreSQL container.

The `docker compose down` command removes the containers and network but keeps the named volume.

The `docker compose down -v` command also removes the named volume, which deletes the PostgreSQL data stored in that volume.

