# Day 8: AWS EC2 Deployment

## Objective

The goal of this task was to deploy my internship project to an AWS EC2 instance and learn how to run an application on a cloud server.

## EC2 Setup and Deployment

I used an Ubuntu EC2 instance named `devops-internship-server` in the Sydney region. After connecting to the server, I installed Docker and tested it using the `hello-world` image, which ran successfully.

I cloned my internship project from GitHub and used Docker Compose to start the Flask application and PostgreSQL database. I checked the containers and reviewed their logs to make sure both services were running.

## Testing Results

I tested the application locally using `curl http://localhost:8000/`. It returned:

```text
My DevOps application is running
```

I also tested the health endpoint using `curl http://localhost:8000/health`. The response was:

```json
{"status":"healthy"}
```

I ran `sudo docker compose ps` and confirmed that the application and database containers were running. The application was accessible on port 8000, while PostgreSQL port 5432 was not published to the host by the Compose configuration.

I then opened the application in my browser using the EC2 public IP address and port 8000. The application loaded successfully.

To understand how security groups affect access, I temporarily removed the inbound rule for port 8000. I could no longer access the application externally, although it was still running on the server. After restoring the rule, I could access it again.

## Security

During this task, I learned why it is important to control access to cloud resources. The application port should only be accessible to the intended users, and PostgreSQL should not be exposed publicly.

I also made sure to keep database credentials in the local `.env` file. AWS credentials, private SSH keys, and other secrets must never be committed to GitHub.

## What I Learned

This task helped me understand how EC2, Docker, and Docker Compose work together to deploy an application. I also learned how to test application endpoints, check running containers, and troubleshoot network access problems using security groups.
