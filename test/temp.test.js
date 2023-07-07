const { addbyone } = require('../src/test');
const assert = require('assert');

describe('Calculator', () => {
  it('should correctly add two numbers', () => {
    assert.strictEqual(addbyone(2), 3);
  });
  
});
