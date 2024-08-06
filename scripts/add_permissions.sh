#!/bin/bash

# Znajdź wszystkie pliki dev-entrypoint.sh w katalogach bin submodułów
submodules=$(find . -type f -name dev-entrypoint.sh -path '*/bin/*')

# Iteruj przez każdy plik dev-entrypoint.sh i dodaj uprawnienia wykonania
for dev_entrypoint in $submodules
do
    echo "Adding execute permission to $dev_entrypoint"
    chmod +x "$dev_entrypoint"
done

echo "Execute permissions added to all dev-entrypoint.sh files."
