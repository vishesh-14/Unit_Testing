COVERAGE_THRESHOLD=50  # Set the desired coverage threshold
COVERAGE_RESULT=$(istanbul report text | awk '/All files/{print substr($NF, 1, length($NF)-1)}')

if [ $(echo "$COVERAGE_RESULT < $COVERAGE_THRESHOLD" | bc) -eq 1 ]; then
  echo "Code coverage below threshold: $COVERAGE_RESULT%"
  exit 1  # Exit with a non-zero status to indicate failure
fi
