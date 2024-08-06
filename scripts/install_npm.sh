#!/bin/bash

# Sprawdź, czy npm jest zainstalowany
if ! command -v npm &> /dev/null
then
    echo "npm not found. Please install npm and try again."
    exit 1
fi

# Znajdź wszystkie katalogi zawierające plik package.json
submodules=$(find . -type f -name package.json -exec dirname {} \;)

# Iteruj przez każdy submoduł
for submodule in $submodules
do
    # Pomijaj katalogi node_modules
    if [[ "$submodule" =~ /node_modules/ ]]; then
        continue
    fi
    
    # Pomijaj submoduły, które już mają katalog node_modules
    if [ -d "$submodule/node_modules" ]; then
        continue
    fi
    
    echo "Navigating to $submodule"
    cd "$submodule" || { echo "Failed to navigate to $submodule"; continue; }
    
    # Sprawdź ponownie, czy package.json istnieje po przejściu do katalogu
    if [ -f package.json ]; then
        echo "Running npm install in $submodule"
        npm install
    fi
    
    # Powróć do katalogu głównego
    cd - > /dev/null
done

echo "npm install completed for all applicable submodules."
