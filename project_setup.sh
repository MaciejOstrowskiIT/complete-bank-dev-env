#!/bin/bash

# Plik dziennika
LOGFILE="project_setup_log.txt"

# Wyczyść lub stwórz plik dziennika
echo "Starting project setup..." > "$LOGFILE"

# Ścieżki do skryptów w folderze ./scripts/
SCRIPT_DIR="./scripts"
PERMISSION_SCRIPT="$SCRIPT_DIR/add_permissions.sh"
NPM_INSTALL_SCRIPT="$SCRIPT_DIR/install_npm.sh"
DOCKER_SCRIPT="$SCRIPT_DIR/start_docker.sh"

# Funkcja do uruchamiania skryptów i rejestrowania wyników
run_script() {
    local script=$1
    echo "Running $script..." | tee -a "$LOGFILE"
    if ! bash "$script" >> "$LOGFILE" 2>&1; then
        echo "Error occurred while running $script. Check the log for details." | tee -a "$LOGFILE"
        exit 1
    fi
}

# Uruchom pierwszy skrypt (dodawanie uprawnień)
run_script "$PERMISSION_SCRIPT"

# Uruchom drugi skrypt (instalacja npm)
run_script "$NPM_INSTALL_SCRIPT"

# Uruchom skrypt Docker (uruchamianie kontenerów)
run_script "$DOCKER_SCRIPT"

echo "Project setup completed." | tee -a "$LOGFILE"
