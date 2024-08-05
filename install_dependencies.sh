#!/bin/bash

# Find all directories containing a package.json file
submodules=$(find . -type f -name package.json -exec dirname {} \;)

# Iterate through each submodule and run npm install if node_modules does not exist
for submodule in $submodules
do
    echo "Checking $submodule"
    
    if [ -d "$submodule/node_modules" ]; then
        echo "node_modules already exists in $submodule. Skipping npm install."
    else
        echo "Navigating to $submodule"
        cd $submodule
        
        if [ -f package.json ]; then
            echo "Running npm install in $submodule"
            npm install
        else
            echo "No package.json found in $submodule. Skipping npm install."
        fi
        
        cd - > /dev/null
    fi
done

echo "npm install completed for all applicable submodules."
