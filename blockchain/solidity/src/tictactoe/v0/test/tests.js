//https://ethereum.stackexchange.com/questions/21210/syntaxerror-unexpected-token-import-on-truffle-test?rq=1

import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should not have a winner for this game", async () => {
    let game = await tictactoe.deployed();
    let winner = await game.showWinner('0x111100aaaa00000000');
    assert.equal(winner.valueOf(), '0x00');
  });

  it("should not process invalid games", async () => {
    let game = await tictactoe.deployed();
    await assertRevert(game.showWinner('0x111100aaaaaa000000'));
  });

})
