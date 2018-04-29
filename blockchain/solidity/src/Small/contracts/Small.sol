pragma solidity ^0.4.0;

contract Small {
    address owner;
    bytes1 contractState;

    constructor() payable public{
        owner = msg.sender;
        contractState = 0x00;
    }

    function set(bytes1 _contractState) payable public{
        contractState = _contractState;
    }

    function get() view public returns (bytes1){
        return contractState;
    }
}

