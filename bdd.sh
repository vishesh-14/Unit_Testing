#!/bin/bash

# Get the list of changed files compared to the previous version
CHANGED_FILES=$(git diff --name-only HEAD^ HEAD)

# If there are no changed files, exit the script with a success status
if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skipping code coverage."
  exit 0
fi

# Run code coverage for the changed files only and generate the XML report
./node_modules/.bin/istanbul cover --include-all-sources --dir coverage --report cobertura --print none ./node_modules/.bin/_mocha -- -R mocha-junit-reporter


# Move the generated XML report to the root directory
mv coverage/coverage.xml ./code-coverage.xml
