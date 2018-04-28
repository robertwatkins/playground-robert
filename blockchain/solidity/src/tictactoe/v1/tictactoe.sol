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

    function validPlayersTakingTurns(bytes9 gameState) pure private returns (bool){
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
    
    function countIfWinning (uint256 playerMoveAtLocation1, uint256 playerMoveAtLocation2, uint256 playerMoveAtLocation3, bytes9 gameState) pure private returns (int, bytes1) {
        int count = 0;
        bytes1 eX = 0x11;
        bytes1 oH = 0xAA;
        if ((gameState[playerMoveAtLocation1] == eX || gameState[playerMoveAtLocation1] == oH) 
                &&(gameState[playerMoveAtLocation1] == gameState[playerMoveAtLocation2] 
                && gameState[playerMoveAtLocation2] == gameState[playerMoveAtLocation3])){
           count++;
        }
        return (count, gameState[playerMoveAtLocation1]);
    }
    
    function hasOnlyOneWinner(bytes9 gameState) pure private returns (bool, bytes1){
        bytes1 winner = 0x0;
        bytes1 matchingValue;
        int count;
        int totalWinnerCount = 0;
        (count, matchingValue) = countIfWinning(0,1,2,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(0,3,6,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(0,4,8,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(1,4,7,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(2,4,6,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(2,5,8,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(3,4,5,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfWinning(6,7,8,gameState);
        if (count > 0) {winner = matchingValue;}
        totalWinnerCount += count;
        return (totalWinnerCount<=1,winner);
    }
    
    /// @author Robert Watkins
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O'.
    ///      Return a boolean indicating the game state is valid or not.
    /// @param gameState represents the current state of the game
    function isValid(bytes9 gameState) private returns (bool, bytes1){
        bool onlyOneWinner;
        bytes1 winner;
        (onlyOneWinner, winner) = hasOnlyOneWinner(gameState);
        bool validGame = validPlayersTakingTurns(gameState) && onlyOneWinner;
        emit gameStateStatus(validGame);
        return (validGame,winner);
    }

    /// @author Robert Watkins
    /// @notice Return a message indicating if the game state is valid
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', 'CAT' (0xFF)
    /// @param gameState represents the current state of the game
    function showWinner(bytes9 gameState) payable public returns (bytes1) {
        bool validGame;
        bytes1 winner;
        (validGame, winner) = isValid(gameState);
	    require(validGame,"Not a valid game state.");
        return winner;
    }
}
