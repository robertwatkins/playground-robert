import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should show the game state of a completed game until the first new player joins.", async () => {
    console.log('------------------------');
    console.log("should show the game state of a completed game until the first new player joins.");
    assert.fail("not implemented");
  });

  it("should show an empty game state when the first player joins", async () => {
    console.log('------------------------');
    console.log("should show an empty game state when the first player joins");
    assert.fail("not implemented");
  });

  it("should show an empty game state when the second player joins", async () => {
    console.log('------------------------');
    console.log("should show an empty game state when the second player joins");
    assert.fail("not implemented");
  });

})