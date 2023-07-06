#!/bin/bash

# Get the list of changed files compared to the previous version
CHANGED_FILES=$(git diff --name-only HEAD^ HEAD)

# If there are no changed files, exit the script with a success status
if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skipping code coverage."
  exit 0
fi

# Set the coverage threshold
THRESHOLD=50

# Run code coverage for the changed files only and generate the XML report
./node_modules/.bin/nyc --reporter=cobertura --include="${CHANGED_FILES}" ./node_modules/.bin/mocha

# Check the coverage threshold
ACTUAL_COVERAGE=$(./node_modules/.bin/nyc report --reporter=text-summary | awk '{print $4}' | sed 's/%//')
COVERAGE_EXIT_STATUS=$?

# If the coverage check fails or the coverage is below the threshold, abort the build
if [ $COVERAGE_EXIT_STATUS -ne 0 ] || (( $(echo "$ACTUAL_COVERAGE < $THRESHOLD" | bc -l) )); then
  echo "Code coverage threshold of $THRESHOLD% not met. Aborting the build."
  exit 1
fi

# Move the generated coverage report to the root directory with the desired name
mv coverage/cobertura-coverage.xml ./code-coverage.xml
