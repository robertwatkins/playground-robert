import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should require 'X' to play first.", async () => {
    console.log('------------------------');
    console.log("should require 'X' to play first.");
    assert.fail("not implemented)";
  });

  it("should reject invalid move location.", async () => {
    console.log('------------------------');
    console.log("should reject invalid move location.");
    assert.fail("not implemented)";
  });

  it("should reject moves made out of turn.", async () => {
    console.log('------------------------');
    console.log("should reject moves made out of turn.");
    assert.fail("not implemented)";
  });

  it("should return 0x00 if there is no current winner.", async () => {
    console.log('------------------------');
    console.log("should return 0x00 if there is no current winner.");
    assert.fail("not implemented)";
  });

  it("should return 0xFF for a 'cat's game'.", async () => {
    console.log('------------------------');
    console.log("should return 0xFF for a 'cat's game'.");
    assert.fail("not implemented)";
  });

  it("should return a player's value after a winning move.", async () => {
    console.log('------------------------');
    console.log("should return a player's value after a winning move.");
    assert.fail("not implemented)";
  });

  it("should reject a move from an account that is not a current player", async () => {
    console.log('------------------------');
    console.log("should reject a move from an account that is not a current player");
    assert.fail("not implemented)";
  });

  it("should reject a move if there is only one player.", async () => {
    console.log('------------------------');
    console.log("should reject a move if there is only one player.");
    assert.fail("not implemented)";
  });
}
