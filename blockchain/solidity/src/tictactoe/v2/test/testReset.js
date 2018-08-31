import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should only allow the owner of the contract reset the game", async () => {
    console.log('------------------------');
    console.log("should only allow the owner of the contract reset the game");
    assert.fail("not implemented");
  });

  it("should not allow non-owners to reset the game", async () => {
    console.log('------------------------');
    console.log("should not allow non-owners to reset the game");
    assert.fail("not implemented");
  });

})
