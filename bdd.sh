#!/bin/bash

# Get the list of changed files compared to the previous version
CHANGED_FILES=$(git diff --name-only HEAD^ HEAD)

# If there are no changed files, exit the script with a success status
if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skipping code coverage."
  exit 0
fi

# Run code coverage for the changed files only and generate the XML report
./node_modules/.bin/nyc --reporter=lcov --include="${CHANGED_FILES}" ./node_modules/.bin/mocha

# Check the coverage threshold
THRESHOLD=50
ACTUAL_COVERAGE=$(./node_modules/.bin/nyc report --reporter=text-summary | awk '{print $4}' | sed 's/%//')
if [ "$(echo "$ACTUAL_COVERAGE < $THRESHOLD" | bc -l)" -eq 1 ]; then
  echo "Code coverage threshold of $THRESHOLD% not met. Aborting the build."
  exit 1
fi
