#!/bin/sh

# Get the list of changed files compared to the previous version
CHANGED_FILES=$(git diff --name-only HEAD^ HEAD)

# If there are no changed files, exit the script with a success status
if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skipping code coverage."
  exit 0
fi

# Run code coverage for the changed files only and generate the report
./node_modules/.bin/nyc --reporter=lcov --include="${CHANGED_FILES}" ./node_modules/.bin/mocha

mv coverage/cobertura-coverage.xml ./test-results.xml
