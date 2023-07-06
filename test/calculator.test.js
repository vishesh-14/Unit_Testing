const { add, sub } = require('../src/calculator');
const assert = require('assert');

describe('Calculator', () => {
  it('should correctly add two numbers', () => {
    assert.strictEqual(add(2, 3), 5);
  });
  
});
