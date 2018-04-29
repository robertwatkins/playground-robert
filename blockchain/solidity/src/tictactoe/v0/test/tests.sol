pragma solidity ^0.4.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/tictactoe.sol";

contract tests {
  function testShowWinnerUsingDeployedContract() public {
    tictactoe game = tictactoe(DeployedAddresses.tictactoe());

    bytes9 gameState = 0x111100aaaaaa110000;
    bytes1 expected = 0xaa;

    Assert.equal(game.showWinner(gameState), expected, "No winner expected for new game.");
  }
}

