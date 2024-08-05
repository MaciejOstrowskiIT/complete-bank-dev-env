#!/bin/bash

# Find all dev-entrypoint.sh files in the bin directories of submodules
submodules=$(find . -type f -name dev-entrypoint.sh -path '*/bin/*')

# Iterate through each dev-entrypoint.sh file and add execute permissions
for dev_entrypoint in $submodules
do
    echo "Adding execute permission to $dev_entrypoint"
    chmod +x "$dev_entrypoint"
done

echo "Execute permissions added to all dev-entrypoint.sh files."
