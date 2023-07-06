const { add, sub } = require('../src/calculator');
const assert = require('assert');

describe('Calculator', () => {
  it('should correctly add two numbers', () => {
    assert.strictEqual(add(2, 3), 5);
  });
  it('should correctly sub two numbers', () => {
    assert.strictEqual(sub(3,2), 1);
  });
});
