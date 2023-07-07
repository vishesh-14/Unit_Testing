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

# Calculate the coverage percentage for the changed files
COVERAGE_THRESHOLD=50
COVERAGE_RESULT=$(./node_modules/.bin/istanbul report --root coverage --include=$CHANGED_FILES lcov | grep -oP 'Lines[^%]*\K[0-9.]+')

# Check if coverage meets the threshold
if (( $(echo "$COVERAGE_RESULT < $COVERAGE_THRESHOLD" | bc -l) )); then
  echo "Code coverage threshold of $COVERAGE_THRESHOLD% not met for changed files. Failing the build."
  exit 1
fi
