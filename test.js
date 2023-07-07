const NYC = require('nyc');
const nyc = new NYC();
const util = require('util');
const exec = util.promisify(require('child_process').exec);
async function getChangedFiles() {
    try {
      // Execute the Git command to get the changed files
      const { stdout } = await exec('git diff --name-only HEAD HEAD~1');
      
      // Split the output into an array of file paths
      const changedFiles = stdout.split('\n').filter(Boolean);
      
      return changedFiles;
    } catch (error) {
      console.error('Error occurred while getting changed files:', error);
      return [];
    }
  }


// Get the list of changed files (e.g., from Step 3)
const changedFiles = getChangedFiles();


// Filter the code coverage for changed files
nyc.exclude(changedFiles);

// Hook into the Mocha test runner
nyc.wrap();

// Run the tests
require('node_modules/bin/_mocha');




