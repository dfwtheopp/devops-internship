# Day 3 DevOps Notes

## Git Workflow

Working directory -> Staging area -> Commit -> Remote repository

## Branch
A branch allows us to work on a feature separately from the main branch.

## Pull Request
A pull request is a request to merge changes from one branch into another.

## Bash
Bash is a command-line shell that can be used to automate tasks.

## Scripts
A shell script is a file containing commands that can be executed together.

## Health Check
The health-check script uses curl to check a URL and obtain its HTTP status code.

HTTP status codes from 200 to 399 are treated as healthy.

The result is recorded with a timestamp in logs/health-check.log.

The script returns exit code 0 when healthy and exit code 1 when unhealthy.

## System Information
The system-info script displays information such as the hostname, current user, current directory, date, and system uptime.
