import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should show 'X' if the game has two players, but no moves have been made.", async () => {
    console.log('------------------------');
    console.log("should show 'X' if the game has two players, but no moves have been made.");
    assert.fail("not implemented)";
  });

  it("should show 0x00 if there are not two players for the game", async () => {
    console.log('------------------------');
    console.log("should show 0x00 if there are not two players for the game");
    assert.fail("not implemented)";
  });

  it("should show 0x00 if the game is over", async () => {
    console.log('------------------------');
    console.log("should show 0x00 if the game is over");
    assert.fail("not implemented)";
  });

}
