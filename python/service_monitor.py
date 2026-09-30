import json
import time
from datetime import datetime

import requests


URLS = [
    "http://localhost",
    "https://github.com",
    "https://www.google.com"
]


def check_service(url):
    start_time = time.perf_counter()

    try:
        response = requests.get(url, timeout=5)

        end_time = time.perf_counter()
        response_time = round(end_time - start_time, 3)

        if 200 <= response.status_code < 400:
            status = "HEALTHY"
        else:
            status = "UNHEALTHY"

        return {
            "url": url,
            "status_code": response.status_code,
            "response_time": response_time,
            "status": status,
            "timestamp": datetime.now().isoformat()
        }

    except requests.exceptions.Timeout:
        end_time = time.perf_counter()
        response_time = round(end_time - start_time, 3)

        return {
            "url": url,
            "status_code": None,
            "response_time": response_time,
            "status": "UNHEALTHY",
            "timestamp": datetime.now().isoformat()
        }

    except requests.exceptions.ConnectionError:
        end_time = time.perf_counter()
        response_time = round(end_time - start_time, 3)

        return {
            "url": url,
            "status_code": None,
            "response_time": response_time,
            "status": "UNHEALTHY",
            "timestamp": datetime.now().isoformat()
        }


def main():
    results = []

    for url in URLS:
        result = check_service(url)
        results.append(result)

        print(
            f"{url} - {result['status']} "
            f"({result['response_time']}s)"
        )

    report = {
        "timestamp": datetime.now().isoformat(),
        "services": results
    }

    with open("reports/service-report.json", "w") as file:
        json.dump(report, file, indent=4)

    print("\nReport saved to reports/service-report.json")


if __name__ == "__main__":
    main()