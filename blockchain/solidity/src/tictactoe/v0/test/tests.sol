pragma solidity ^0.4.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/tictactoe.sol";

contract tests {
  function testValidGameNoWinner() public {
    tictactoe game = tictactoe(DeployedAddresses.tictactoe());

    bytes9 gameState = 0x111100aaaa00000000;
    bytes1 expected = 0x00;

    Assert.equal(game.showWinner(gameState), expected, "No winner expected for this game. ");
  }

  function testValidGameWinnerFound() public {
    tictactoe game = new tictactoe();
    bytes9 gameState = 0x111100aaaaaa110000;
    bytes1 expected = 0xaa;

    Assert.equal(game.showWinner(gameState), expected, "Winner expected for this game.");
  }

  /* Removed test that resulted in a 'revert' since solidity does not handle this well at the moment */

}
