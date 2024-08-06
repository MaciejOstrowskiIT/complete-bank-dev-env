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
    bash "$script" >> "$LOGFILE" 2>&1 &
    local pid=$!

    # Pasek postępu
    local delay=0.1
    local spinstr='|/-\'
    local temp

    echo -n "Processing $script "
    local progress_indicator=" [|]"

    while ps -p $pid > /dev/null; do
        temp=${spinstr#?}
        progress_indicator=" [${spinstr:0:1}]"
        spinstr=$temp${spinstr%"$temp"}
        printf "\rProcessing $script$progress_indicator"
        sleep $delay
    done
    wait $pid

    if [ $? -ne 0 ]; then
        echo -e "\nError occurred while running $script. Check the log for details." | tee -a "$LOGFILE"
        exit 1
    fi

    printf "\rProcessing $script [Done]\n"
}

# Liczba skryptów do uruchomienia
total_scripts=3
current_script=0

# Uruchom pierwszy skrypt (dodawanie uprawnień)
current_script=$((current_script + 1))
run_script "$PERMISSION_SCRIPT"

# Uruchom drugi skrypt (instalacja npm)
current_script=$((current_script + 1))
run_script "$NPM_INSTALL_SCRIPT"

# Uruchom skrypt Docker (uruchamianie kontenerów)
current_script=$((current_script + 1))
run_script "$DOCKER_SCRIPT"

echo "Project setup completed." | tee -a "$LOGFILE"
