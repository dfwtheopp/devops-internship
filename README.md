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
