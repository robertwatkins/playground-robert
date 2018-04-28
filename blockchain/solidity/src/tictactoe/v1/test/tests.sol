import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/tictactoe.sol";

contract TestTicTacToe {
  function testShowWinnerUsingDeployedContract() {
    tictactoe game = tictactoe(DeployedAddresses.tictactoe());

    bytes1 expected = 0x00;

    Assert.equal(game.showWinner(0x00), expected, "No winner expected for new game.");
  }
}

