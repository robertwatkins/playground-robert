//https://ethereum.stackexchange.com/questions/21210/syntaxerror-unexpected-token-import-on-truffle-test?rq=1

import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should have a winner for this game", async () => {
    let game = await tictactoe.deployed();
    await game.makeMove('0x11',0);
    await game.makeMove('0xaa',3);
    await game.makeMove('0x11',1);
    await game.makeMove('0xaa',4);
    let winner = await game.makeMove('0x11',2);
    console.log('winner:' + winner.valueOf());
    assert.equal(winner.valueOf(), '0x11');
  });

  it("should not process invalid moves", async () => {
    let game = await tictactoe.deployed();
    await assertRevert(game.makeMove('0x11',11));
  });

})