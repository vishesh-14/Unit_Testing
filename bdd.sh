#!/bin/bash

# Run the tests with code coverage
./node_modules/.bin/nyc --reporter=lcov --reporter=text-lcov _mocha

# Calculate the coverage percentage
./node_modules/.bin/nyc report --reporter=text-summary

# Check the coverage threshold and exit with an appropriate status
./node_modules/.bin/nyc check-coverage --lines 50
