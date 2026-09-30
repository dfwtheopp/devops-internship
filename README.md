# DevOps Internship

This repository contains my DevOps internship work and learning exercises.

## Project Structure

- `day-1/` - Linux and Git practice
- `scripts/system-info.sh` - Displays basic system information
- `scripts/health-check.sh` - Checks the health of a website
- `logs/` - Stores health-check logs
- `notes/` - DevOps learning notes
- `networking/` - Networking notes

## System Information

Run:

```bash
./scripts/system-info.sh



# Day 4 - Bash Automation

## Cron Health Check

The health-check script is scheduled to run every 5 minutes.

Cron expression:

`*/5 * * * *`

The five fields represent:

1. Minute: `*/5` - every 5 minutes
2. Hour: `*` - every hour
3. Day of month: `*` - every day
4.  Month: `*` - every month
5. Day of week: `*` - every day of the week

The scheduled job checks the local Nginx service using:

`http://localhost`

The output is appended to:

`logs/cron-health-check.log`


## Day 5 — Python for DevOps Automation

### Goal

Use Python to automate DevOps tasks that can become difficult to manage with Bash.

### Practice 1 — Multi-Service Monitor

Created `python/service_monitor.py`.

The script:

* Checks multiple URLs.
* Records HTTP status codes.
* Measures response time.
* Reports services as healthy or unhealthy.
* Records timestamps.
* Handles timeouts and connection errors.
* Saves the results to `reports/service-report.json`.

### Practice 2 — Log Analyzer

Created `python/log_analyzer.py`.

The script:

* Reads `logs/application.log`.
* Counts INFO, WARNING, and ERROR messages.
* Extracts ERROR entries.
* Generates a JSON summary.
* Saves the result to `reports/log-analysis-report.json`.

### Practice 3  DevOps System Checker

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


#Failure Testing

Three failure tests were performed:

1. *Invalid URL*

   * Tested a nonexistent website.
   * The program reported the connection/name-resolution problem without crashing.

2. *Unavailable Service*

   * Stopped Nginx.
   * The program detected that the service was inactive and reported the problem.

3. *Invalid Input*

   * Provided too many command-line arguments.
   * The program displayed a clear error message and usage instructions instead of producing an unreadable traceback.

After testing, the system was restored to its normal working state.

# Python Environment

A Python virtual environment was created using `.venv`.

The `requests` library was installed and recorded in `requirements.txt`.

The `.venv/` directory is excluded from Git using `.gitignore`.

