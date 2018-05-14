import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should allow a player to join right after contract has deployed", async () => {
    console.log('------------------------');
    console.log("should allow a player to join right after contract has deployed");
    assert.fail("not implemented)";
  });

  it("should allow a player to join right after a completed game.", async () => {
    console.log('------------------------');
    console.log("should allow a player to join right after a completed game.");
    assert.fail("not implemented)";
  });

  it("The first player to join should be the 'X' player.", async () => {
    console.log('------------------------');
    console.log("The first player to join should be the 'X' player.");
    assert.fail("not implemented)";
  });

}
