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

    /// @author Robert Watkins
    /// @dev We are simply counting the instances of each players mark to ensure there is no obvious cheating.
    /// @param gameState represents the current state of the game
    function validPlayersTakingTurns(bytes9 gameState) pure private returns (bool){
      bool validPlayers = true;
      bytes1 currentSpaceValue;
      bytes1 eX = 0x11;
      bytes1 oH = 0xAA;
      bytes1 unplayed = 0x00;
      int eXCount = 0;
      int oHCount = 0;
      uint i;
      
      //playing spaces should only have valid entries (X,O,unplayed)
      for (i=0; i<9; i++){
        currentSpaceValue = gameState[i];
        if (currentSpaceValue == eX) {eXCount++;}
        if (currentSpaceValue == oH) {oHCount++;}
        validPlayers = (validPlayers && (currentSpaceValue == eX || currentSpaceValue == oH || currentSpaceValue == unplayed) );
      }
      
      //the difference in the number of moves for each player should not be off by more than 1
      //and only the X player could have more moves.
      int diffInMoveCount = eXCount - oHCount;
      bool takingTurns = (diffInMoveCount == 1 || diffInMoveCount == 0 );
      
      return (validPlayers && takingTurns);
    }
    
    /// @author Robert Watkins
    /// @dev we will send a count of '1' if the pattern of player moves match values in the game state.
    ///      The matching value will default to 'unplayed' if the count is 0. Otherwise, the matching
    ///      player mark will be returned.
    /// @param gameState represents the current state of the game
    function countIfMatching (uint256 playerMoveAtLocation1, uint256 playerMoveAtLocation2, uint256 playerMoveAtLocation3, bytes9 gameState) pure private returns (int, bytes1) {
        int count = 0;
        bytes1 eX = 0x11;
        bytes1 oH = 0xAA;
        bytes1 unplayed = 0x00;
        bytes1 matchingValue = unplayed;
        if (gameState[playerMoveAtLocation1] != unplayed) {
            if ((gameState[playerMoveAtLocation1] == eX || gameState[playerMoveAtLocation1] == oH) 
                    &&(gameState[playerMoveAtLocation1] == gameState[playerMoveAtLocation2] 
                    && gameState[playerMoveAtLocation2] == gameState[playerMoveAtLocation3])){
               count++;
            }
            matchingValue = gameState[playerMoveAtLocation1];
        }
        return (count, matchingValue);
    }
    
    /// @author Robert Watkins
    /// @dev We will check for matching values (X,O,unplayed) for winning patters (first row, diagonal, etc.)
    ///      and return how many winning patterns found and the player for the last winning pattern found.
    ///      This implies that if there is exactly one winner, it is the last one found.
    /// @param gameState represents the current state of the game
    function hasOnlyOneWinner(bytes9 gameState) pure private returns (bool, bytes1){
        bytes1 unplayed = 0x00;
        bytes1 lastFoundWinner = unplayed;
        bytes1 matchingValue;
        int count;
        int totalWinnerCount = 0;
        (count, matchingValue) = countIfMatching(0,1,2,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(0,3,6,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(0,4,8,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(1,4,7,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(2,4,6,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(2,5,8,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(3,4,5,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(6,7,8,gameState);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        return (totalWinnerCount<=1,lastFoundWinner);
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
        bytes1 unplayed = 0x00;
        bytes1 cat = 0xFF;
        (validGame, winner) = isValid(gameState);
        require(validGame,"Not a valid game state.");
        
        if (winner == unplayed){
            bool isCatWinner = true; 
            uint i;
            for (i=0; i<9; i++){
                isCatWinner = (isCatWinner && (gameState[i] != unplayed));
            }
            if (isCatWinner) {winner = cat;}
        }
        return winner;
    }
}


