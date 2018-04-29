pragma solidity ^0.4.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Small.sol";

contract TestSmall {
  function testGet() public {
    Small myContract = Small(DeployedAddresses.Small());

    bytes1 expected = 0x0;

    Assert.equal(myContract.get(), expected, "Default value must be 0.");
  }
}
