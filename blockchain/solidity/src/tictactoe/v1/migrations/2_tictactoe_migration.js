var tictactoe = artifacts.require("./tictactoe.sol");

module.exports = function(deployer) {
  deployer.deploy(tictactoe);
};
