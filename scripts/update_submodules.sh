#!/bin/bash

# Ścieżka do pliku dziennika
LOGFILE="./logs/update_submodules_log.txt"

# Utwórz plik dziennika, jeśli nie istnieje
echo "Starting git submodule update..." > "$LOGFILE"

# Aktualizacja submodułów
echo "Running 'git submodule update --init --recursive'..." | tee -a "$LOGFILE"
if git submodule update --init --recursive >> "$LOGFILE" 2>&1; then
    echo "Submodules updated successfully." | tee -a "$LOGFILE"
else
    echo "Error occurred while updating submodules. Check the log for details." | tee -a "$LOGFILE"
    exit 1
fi
