# Server Health Toolkit

A Bash project that generates a basic health report for a Linux system.

## What it checks

- Root disk usage
- Running process count
- HTTP status from example.com

## How to run

From the project directory, run `./server-health.sh`.

The generated report is saved in the `reports/` folder.

## Docker

Build the image from the project directory:
`docker build -t server-health-tool:multi-stage .`

Run it and save reports in `reports/`:
`docker run --rm --user "$(id -u):$(id -g)" -v "$PWD/reports:/app/reports" server-health-tool:multi-stage`

The build checks the script with ShellCheck. Reports are saved on the host in `reports/`.
