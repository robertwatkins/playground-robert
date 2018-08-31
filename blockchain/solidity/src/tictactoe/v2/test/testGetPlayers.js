import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should show the players of a completed game until the first new player joins.", async () => {
    console.log('------------------------');
    console.log("should show the players of a completed game until the first new player joins.");
    assert.fail("not implemented");
  });

  it("should show only one player after the first player joins", async () => {
    console.log('------------------------');
    console.log("should show only one player after the first player joins");
    assert.fail("not implemented");
  });

  it("should show both players after the second player joins", async () => {
    console.log('------------------------');
    console.log("should show both players after the second player joins");
    assert.fail("not implemented");
  });

})
