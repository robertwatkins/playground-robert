//https://ethereum.stackexchange.com/questions/21210/syntaxerror-unexpected-token-import-on-truffle-test?rq=1

import assertRevert from '../helpers/assertRevert';

const tictactoe = artifacts.require("tictactoe");

contract('Tictactoe Test', async (accounts) => {

  it("should have a winner for this game", async () => {
    console.log('------------------------');
    console.log("should have a winner for this game");
    let game = await tictactoe.deployed();
    await game.makeMove('0x11',0);
    await game.makeMove('0xaa',3);
    await game.makeMove('0x11',1);
    await game.makeMove('0xaa',4);
    await game.makeMove('0x11',2);
    let winner = await game.showWinner();
    let gameState = await game.getGameState();
    printGameState(gameState);
    console.log('winner:' + winner);
    assert.equal(winner.valueOf(), '0x11');
  });

  it("should not process invalid moves. (X tries to move to space 9)", async () => {
    console.log('------------------------');
    console.log("should not process invalid moves. (X tries to move to space 9)");
    let game = await tictactoe.deployed();
    assertRevert( game.makeMove('0x11',9));
  });

  it("should not process invalid moves. (undefined player tries to move to space 0)", async () => {
    console.log('------------------------');
    console.log("should not process invalid moves. (undefined player tries to move to space 0)");
    let game = await tictactoe.deployed();
    assertRevert( game.makeMove('X',9));
  });


  it("should allow a game to continue after an invalid move.", async() => {
    console.log('------------------------');
    console.log("should allow a game to continue after an invalid move.");
    let game = await tictactoe.new();
    await game.makeMove('0x11',0);
    console.log("X to space 0");
    await game.makeMove('0xaa',3);
    console.log("O to space 3");
    await game.makeMove('0x11',1);
    console.log("X to space 1");
    await game.makeMove('0xaa',4);
    console.log("O to space 4");
    assertRevert(game.makeMove('0xaa',4));
    console.log("O to space 4. Whoops, tried to make the same move again. Continuing...");
    await game.makeMove('0x11',2);
    console.log("X to space 2");
    let gameState = await game.getGameState();
    printGameState(gameState);
  });
/*
  it("should start with an empty game state.", async() => {
    assert.fail("Not Implemented");
  });

  it("should show the game state that includes the most recent move.", async() => {
    assert.fail("Not Implemented");
  });

  it("After a winning game, the game state should be empty.", async() => {
    assert.fail("Not Implemented");
  });

  it("Only the X player can go first.", async() => {
    assert.fail("Not Implemented");
  });

  it("if no winner exists and no moves are left, then it's a cat's game.", async() => {
    assert.fail("Not Implemented");
  });
*/

})

function printGameState (gameState) {
    /// 0 | 1 | 2 
    ///---+---+---
    /// 3 | 4 | 5 
    ///---+---+---
    /// 6 | 7 | 8

    let moves = "";
    ///convert from bytes to letters
    for (let i = 1; i<= 9; i++) {
        
        let rawMove = gameState[i*2];
        switch (rawMove) {
          case "1":
            moves = moves + "X";
            break;
          case "a":
            moves = moves + "O";
            break;
          case "0":
            moves = moves + " ";
            break;
          default:
            moves = moves + "?";
            break;
        }
    }
    console.log(" " + moves[0] + " | " + moves[1] + " | " + moves[2]);
    console.log("---+---+---");
    console.log(" " + moves[3] + " | " + moves[4] + " | " + moves[5]);
    console.log("---+---+---");
    console.log(" " + moves[6] + " | " + moves[7] + " | " + moves[8]);
}
