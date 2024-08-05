#!/bin/bash

# Plik dziennika
LOGFILE="project_setup_log.txt"

# Znajdź wszystkie pliki dev-entrypoint.sh w katalogach bin submodułów
submodules=$(find . -type f -name dev-entrypoint.sh -path '*/bin/*')

# Iteruj przez każdy plik dev-entrypoint.sh i dodaj uprawnienia wykonania
for dev_entrypoint in $submodules
do
    echo "Adding execute permission to $dev_entrypoint" | tee -a "$LOGFILE"
    chmod +x "$dev_entrypoint" 2>> "$LOGFILE"
done

echo "Execute permissions added to all dev-entrypoint.sh files." | tee -a "$LOGFILE"
