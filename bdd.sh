#!/bin/bash

# Run the tests with code coverage using full path to Mocha executable
./node_modules/.bin/nyc --reporter=lcov --reporter=text-lcov ./node_modules/.bin/mocha

# Calculate the coverage percentage
./node_modules/.bin/nyc report --reporter=text-summary

# Check the coverage threshold and exit with an appropriate status
./node_modules/.bin/nyc check-coverage --lines 50
