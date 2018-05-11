pragma solidity ^0.4.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/tictactoe.sol";

contract tests {
  function testValidGameNoWinner() public {
    tictactoe game = tictactoe(DeployedAddresses.tictactoe());

    bytes1 player = 0x11;
    uint256 moveLocation = 0;
    bytes1 expected = 0x00;

    Assert.equal(game.makeMove(player,moveLocation), expected, "No winner expected for this game. ");
  }
}
