pragma solidity ^0.4.0;

/// @title tictactoe
/// @author Robert Watkins
/// @notice An experiment in writing Solidity
contract tictactoe {
    address owner;

    constructor() public{
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }

    event gameStateStatus(bool status);

    /// @author Robert Watkins
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for '0'.
    ///      Return a boolean indicating the game state is valid or not.
    /// @param gameState represents the current state of the game
    function isValid(bytes9 gameState) private returns (bool){
      bool validGame = true;
      bytes1 currentSpaceValue;
      bytes1 eX = 0x11;
      bytes1 oH = 0xAA;
      bytes1 unused = 0x00;
      int eXCount = 0;
      int oHCount = 0;
      for (uint i=1; i<9; i++){
        currentSpaceValue = gameState[i];
        if (currentSpaceValue == eX) {eXCount++;}
        if (currentSpaceValue == oH) {oHCount++;}
        validGame = (validGame && (currentSpaceValue == eX || currentSpaceValue == oH || currentSpaceValue == unused) );
      }
      int diffInMoveCount = eXCount - oHCount;
      //the difference in moves should not be off by more than 1
      validGame = validGame && (diffInMoveCount == 1 || diffInMoveCount == 0 || diffInMoveCount == -1);
      emit gameStateStatus(validGame);
      return validGame;
    }

    /// @author Robert Watkins
    /// @notice Return a message indicating if the game state is valid
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for '0', 'CAT' (0xFF)
    /// @param gameState represents the current state of the game
    function showWinner(bytes9 gameState) payable public returns (bytes4) {
	    require(isValid(gameState));
        return 0x00000000;
    }

}


