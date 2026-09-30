import json

LOG_FILE = "logs/application.log"
REPORT_FILE = "reports/log-analysis-report.json"


def analyze_log():
    counts = {
        "INFO": 0,
        "WARNING": 0,
        "ERROR": 0
    }

    errors = []

    with open(LOG_FILE, "r") as file:
        for line in file:
            parts = line.split()

            level = parts[2]

            if level in counts:
                counts[level] += 1

            if level == "ERROR":
                errors.append(line.strip())

    report = {
        "log_file": LOG_FILE,
        "summary": counts,
        "errors": errors
    }

    with open(REPORT_FILE, "w") as file:
        json.dump(report, file, indent=4)

    print("Log analysis completed.")
    print(f"INFO: {counts['INFO']}")
    print(f"WARNING: {counts['WARNING']}")
    print(f"ERROR: {counts['ERROR']}")
    print(f"Report saved to {REPORT_FILE}")


if __name__ == "__main__":
    analyze_log()