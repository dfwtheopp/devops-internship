import json
import platform
import shutil
import subprocess
import sys
from datetime import datetime

import requests


REPORT_FILE = "reports/system-report.json"


# Get disk usage
def get_disk_usage():
    total, used, free = shutil.disk_usage("/")

    return {
        "total_gb": round(total / (1024 ** 3), 2),
        "used_gb": round(used / (1024 ** 3), 2),
        "free_gb": round(free / (1024 ** 3), 2)
    }


# Get memory usage
def get_memory_usage():
    result = subprocess.run(
        ["free", "-m"],
        capture_output=True,
        text=True
    )

    lines = result.stdout.splitlines()
    memory_line = lines[1].split()

    return {
        "total_mb": int(memory_line[1]),
        "used_mb": int(memory_line[2]),
        "free_mb": int(memory_line[3])
    }


# Get hostname
def get_hostname():
    return platform.node()


# Get system uptime
def get_uptime():
    result = subprocess.run(
        ["uptime", "-p"],
        capture_output=True,
        text=True
    )

    return result.stdout.strip()


# Check if a Linux service is running
def check_service(service_name):
    result = subprocess.run(
        ["systemctl", "is-active", service_name],
        capture_output=True,
        text=True
    )

    status = result.stdout.strip()

    return {
        "service": service_name,
        "status": status,
        "running": status == "active"
    }


# Check if a website is reachable
def check_url(url):
    try:
        response = requests.get(url, timeout=5)

        return {
            "url": url,
            "status_code": response.status_code,
            "healthy": 200 <= response.status_code < 400
        }

    except requests.exceptions.RequestException as error:
        return {
            "url": url,
            "status_code": None,
            "healthy": False,
            "error": str(error)
        }


def main():

    # ==========================================
    # FAILURE TEST 3: INVALID INPUT
    # ==========================================
    # This checks whether too many command-line
    # arguments are given.
    
    if len(sys.argv) > 2:
        print("Error: Too many arguments.")
        print("Usage: python python/devops_check.py [service]")
        sys.exit(1)


    # Default service
    service_name = "nginx"


    # If a service name is provided, use it
    if len(sys.argv) == 2:
        service_name = sys.argv[1]


    # ==========================================
    # NORMAL URL CHECKS
    # ==========================================
    # These are the normal URLs we want to monitor.
    # The fake URL used during Failure Test 1
    # has been removed.

    urls = [
        check_url("http://localhost"),
        check_url("https://github.com")
    ]


    # ==========================================
    # CREATE SYSTEM REPORT
    # ==========================================

    report = {
        "timestamp": datetime.now().isoformat(),
        "hostname": get_hostname(),
        "uptime": get_uptime(),
        "disk_usage": get_disk_usage(),
        "memory_usage": get_memory_usage(),
        "service": check_service(service_name),
        "urls": urls
    }


    # Save the report as JSON
    with open(REPORT_FILE, "w") as file:
        json.dump(report, file, indent=4)


    print("DevOps system check completed.")
    print(f"Report saved to {REPORT_FILE}")


if __name__ == "__main__":
    main()