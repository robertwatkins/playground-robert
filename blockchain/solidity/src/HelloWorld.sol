pragma solidity ^0.4.0;

/// @title Hello World'
/// @author Robert Watkins
/// @notice An experiment in writing Solidity
contract HelloWorld {
    address owner;

    constructor() public{
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }

    /// @author Robert Watkins
    /// @notice Return 'Hello World!' as a byte array
    /// @dev This will need to be converted from hex to UTF8 to be able to read
    /// @return a bytes16 version of 'Hello World!'
    function hello() pure public returns (bytes16) {
        return "Hello World!";
    }

}

