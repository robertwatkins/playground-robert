pragma solidity ^0.4.0;

/// @title tictactoe
/// @author Robert Watkins
/// @notice An experiment in writing Solidity
contract tictactoe {
    address owner;

    constructor() payable public{
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }

    event gameStateStatus(bool status);

    function validPlayersTakingTurns(bytes9 gameState) private returns (bool){
      bool validPlayers = true;
      bytes1 currentSpaceValue;
      bytes1 eX = 0x11;
      bytes1 oH = 0xAA;
      bytes1 unused = 0x00;
      int eXCount = 0;
      int oHCount = 0;
      uint i;
      
      //playing spaces should only have valid entries (X,O,unused)
      for (i=0; i<9; i++){
        currentSpaceValue = gameState[i];
        if (currentSpaceValue == eX) {eXCount++;}
        if (currentSpaceValue == oH) {oHCount++;}
        validPlayers = (validPlayers && (currentSpaceValue == eX || currentSpaceValue == oH || currentSpaceValue == unused) );
      }
      
      //the difference in the number of moves for each player should not be off by more than 1
      int diffInMoveCount = eXCount - oHCount;
      bool takingTurns = (diffInMoveCount == 1 || diffInMoveCount == 0 || diffInMoveCount == -1);
      
      return (validPlayers && takingTurns);
    }
    
    function hasOnlyOneWinner(bytes9 gameState)private returns (bool){
        bool noMoreThanOneWinner = ((gameState[0] == gameState[1] && gameState[1] == gameState[2])
               ^(gameState[0] == gameState[3] && gameState[3] == gameState[6])
               ^(gameState[0] == gameState[4] && gameState[4] == gameState[8])
               ^(gameState[1] == gameState[4] && gameState[4] == gameState[7])
               ^(gameState[2] == gameState[4] && gameState[4] == gameState[6])
               ^(gameState[2] == gameState[5] && gameState[5] == gameState[8])
               ^(gameState[3] == gameState[4] && gameState[4] == gameState[5])
               ^(gameState[6] == gameState[7] && gameState[7] == gameState[8]));
        bool atLeastOneWinner = ((gameState[0] == gameState[1] && gameState[1] == gameState[2])
               ||(gameState[0] == gameState[3] && gameState[3] == gameState[6])
               ||(gameState[0] == gameState[4] && gameState[4] == gameState[8])
               ||(gameState[1] == gameState[4] && gameState[4] == gameState[7])
               ||(gameState[2] == gameState[4] && gameState[4] == gameState[6])
               ||(gameState[2] == gameState[5] && gameState[5] == gameState[8])
               ||(gameState[3] == gameState[4] && gameState[4] == gameState[5])
               ||(gameState[6] == gameState[7] && gameState[7] == gameState[8]));
        
        return (noMoreThanOneWinner && atLeastOneWinner);
    }
    
    /// @author Robert Watkins
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for '0'.
    ///      Return a boolean indicating the game state is valid or not.
    /// @param gameState represents the current state of the game
    function isValid(bytes9 gameState) private returns (bool){
      bool validGame = validPlayersTakingTurns(gameState) && hasOnlyOneWinner(gameState);
      emit gameStateStatus(validGame);
      return validGame;
    }

    /// @author Robert Watkins
    /// @notice Return a message indicating if the game state is valid
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', 'CAT' (0xFF)
    /// @param gameState represents the current state of the game
    function showWinner(bytes9 gameState) payable public returns (bytes4) {
	    require(isValid(gameState),"Not a valid game state.");
        return 0x00000000;
    }

}


