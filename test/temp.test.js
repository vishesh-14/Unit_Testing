const { addbyone } = require('../src/test');
const assert = require('assert');

describe('Calculator', () => {
  it('should correctly add by one', () => {
    assert.strictEqual(addbyone(2), 3);
  });
  
});
