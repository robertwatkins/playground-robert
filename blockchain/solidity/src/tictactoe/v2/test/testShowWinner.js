import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should show 'X' if 'X' is the winner", async () => {
    console.log('------------------------');
    console.log("should show 'X' if 'X' is the winner");
    assert.fail("not implemented");
  });

  it("should show 'O' if 'O' is the winner", async () => {
    console.log('------------------------');
    console.log("should show 'O' if 'O' is the winner");
    assert.fail("not implemented");
  });

  it("should show 0x00 if there is no winner and the game is not complete", async () => {
    console.log('------------------------');
    console.log("should show 0x00 if there is no winner and the game is not complete");
    assert.fail("not implemented");
  });

  it("should show 0xFF if there is no winner and the game is complete", async () => {
    console.log('------------------------');
    console.log("should show 0xFF if there is no winner and the game is complete");
    assert.fail("not implemented");
  });
})
