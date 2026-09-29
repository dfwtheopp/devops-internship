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