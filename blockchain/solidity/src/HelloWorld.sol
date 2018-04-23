pragma solidity ^0.4.0;

contract HelloWorld {
    address owner;

    function HelloWorld() public{
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }

    function hello() public constant returns (string) {
        return "Hello World!";
    }

}
