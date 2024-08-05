#!/bin/bash

# Plik dziennika
LOGFILE="project_setup_log.txt"

# Sprawdź, czy npm jest zainstalowany
if ! command -v npm &> /dev/null
then
    echo "npm not found. Please install npm and try again." | tee -a "$LOGFILE"
    exit 1
fi

# Znajdź wszystkie katalogi zawierające plik package.json
submodules=$(find . -type f -name package.json -exec dirname {} \;)

# Iteruj przez każdy submoduł
for submodule in $submodules
do
    # Sprawdź, czy katalog node_modules jest rodzicem katalogu
    if [[ "$submodule" =~ /node_modules/ ]]; then
        echo "Skipping $submodule, it's inside node_modules" | tee -a "$LOGFILE"
        continue
    fi
    
    # Sprawdź, czy katalog node_modules istnieje w katalogu submodułu
    if [ -d "$submodule/node_modules" ]; then
        echo "node_modules already exists in $submodule. Skipping submodule." | tee -a "$LOGFILE"
        continue
    fi
    
    echo "Navigating to $submodule" | tee -a "$LOGFILE"
    cd "$submodule" || { echo "Failed to navigate to $submodule" | tee -a "$LOGFILE"; continue; }
    
    # Sprawdź ponownie, czy package.json istnieje po przejściu do katalogu
    if [ -f package.json ]; then
        echo "Running npm install in $submodule" | tee -a "$LOGFILE"
        npm install 2>> "$LOGFILE"
    else
        echo "No package.json found in $submodule. Skipping npm install." | tee -a "$LOGFILE"
    fi
    
    # Powróć do katalogu głównego
    cd - > /dev/null
done

echo "npm install completed for all applicable submodules." | tee -a "$LOGFILE"