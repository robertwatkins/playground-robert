pragma solidity ^0.4.0;

contract HelloWorld {
    address owner;

    constructor() public{
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }

    function hello() pure public returns (string) {
        return "Hello World!";
    }

}

