#!/bin/bash

# Plik dziennika
LOGFILE="project_setup_log.txt"

# Uruchomienie Docker Compose
echo "Running 'sudo docker-compose up'..." | tee -a "$LOGFILE"
sudo docker-compose up -d >> "$LOGFILE" 2>&1

if [ $? -ne 0 ]; then
    echo "Error occurred while running 'docker-compose up'. Check the log for details." | tee -a "$LOGFILE"
    exit 1
fi

echo "Docker containers started successfully." | tee -a "$LOGFILE"
