#!/bin/sh

# Get the list of changed files compared to the previous version
CHANGED_FILES=$(git diff --name-only HEAD^ HEAD)

# If there are no changed files, exit the script with a success status
if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skipping code coverage."
  exit 0
fi

# Run code coverage for the changed files only
./node_modules/.bin/nyc --reporter=lcov --reporter=text-lcov --include="${CHANGED_FILES}" ./node_modules/.bin/mocha

# Calculate the coverage percentage
./node_modules/.bin/nyc report --reporter=text-summary

# Check the coverage threshold
COVERAGE_THRESHOLD=$(./node_modules/.bin/nyc check-coverage --lines 50)
if [ "$COVERAGE_THRESHOLD" != "All coverage thresholds met." ]; then
  echo "Code coverage threshold not met. Aborting the build."
  exit 1
fi
