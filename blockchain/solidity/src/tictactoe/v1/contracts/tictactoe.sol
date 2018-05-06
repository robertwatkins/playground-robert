pragma solidity ^0.4.0;

/// @title tictactoe
/// @author Robert Watkins
/// @notice An experiment in writing Solidity
contract tictactoe {
    address owner;
    bytes9 gameState;
    bytes9 nextPlayer;
    
    // Players and Winner Options
    bytes1 constant xPlayer = 0x11;
    bytes1 constant oPlayer = 0xAA;
    bytes1 constant unplayed = 0x00;
    bytes1 constant cat = 0xFF;
        
    constructor() payable public{
        owner = msg.sender;
        gameState = 0x000000000000000000;
        nextPlayer = xPlayer;
    }

    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }
    
    /// @author Robert Watkins
    /// @notice Return a message indicating if the game state is valid
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', 'CAT' (0xFF)
    function showWinner() view public returns (bytes1) {
        bool validGame;
        bytes1 winner;

        (validGame, winner) = isValidGameState();
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
    
    /// @author Robert Watkins
    /// @notice Send player's move, verify it's valid and return the current winner to this point
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', 'CAT' (0xFF).
    ///      Also, game moves are numbered like this:
    /// 0 | 1 | 2 
    ///---+---+---
    /// 3 | 4 | 5 
    ///---+---+---
    /// 6 | 7 | 8
    function makeMove(bytes1 playerMakingMove, uint256 moveLocation) payable public returns (bytes9){
        require (isValidPlayer(playerMakingMove),"Invalid Player");
        require (isValidMoveLocation(moveLocation), "Invalid Move");
        nextPlayer = playerAfter(playerMakingMove);
        //create an empty game and add the players move in location, 
        //then use bitwise 'or' to modifiy the gamestate
        bytes9 moveMask = playerMakingMove << (moveLocation * 8);
        gameState = gameState | moveMask;
        return showWinner();
    }

    /// @author Robert Watkins
    /// @notice Return current game state
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', 'CAT' (0xFF)
    ///      Also, game moves are numbered like this:
    /// 0 | 1 | 2 
    ///---+---+---
    /// 3 | 4 | 5 
    ///---+---+---
    /// 6 | 7 | 8
    function getGameState() view public returns (bytes9) {
        return gameState;
    }
    
    /// @author Robert Watkins
    /// @notice returns the player to play next, based on the current player
    function playerAfter(bytes1 player) view private returns (bytes1) {
        require(isValidPlayer(player));
        if (player== xPlayer) {
            return oPlayer;
        } else {
            return xPlayer;
        }
    }
    
    /// @author Robert Watkins
    /// @notice validate that the move being requested is on the board and not already played
    /// @dev Game moves are numbered like this:
    /// 0 | 1 | 2 
    ///---+---+---
    /// 3 | 4 | 5 
    ///---+---+---
    /// 6 | 7 | 8
    function isValidMoveLocation (uint256 location) view private returns (bool){
        bool validMove;
        validMove = ((location >= 0x0) && (location <= 0x8));
        validMove = (gameState[location] == unplayed);
        return validMove;
    }
    
    /// @author Robert Watkins
    /// @notice validate that the player making the move is an X or O and it's their turn 
    function isValidPlayer(bytes1 player) view private returns (bool){
        bool validPlayer;
        validPlayer = (player == nextPlayer)
                      && ((player == xPlayer)||(player == oPlayer));
        return validPlayer;
    }
    /// @author Robert Watkins
    /// @dev We are simply counting the instances of each players mark to ensure there is no obvious cheating.
    function validPlayersTakingTurns() view private returns (bool){
      bool validPlayers = true;
      bytes1 currentSpaceValue;
      int xPlayerCount = 0;
      int oPlayerCount = 0;
      uint i;
      
      //playing spaces should only have valid entries (X,O,unplayed)
      for (i=0; i<9; i++){
        currentSpaceValue = gameState[i];
        if (currentSpaceValue == xPlayer) {xPlayerCount++;}
        if (currentSpaceValue == oPlayer) {oPlayerCount++;}
        validPlayers = (validPlayers && (currentSpaceValue == xPlayer || currentSpaceValue == oPlayer || currentSpaceValue == unplayed) );
      }
      
      //the difference in the number of moves for each player should not be off by more than 1
      //and only the X player could have more moves.
      int diffInMoveCount = xPlayerCount - oPlayerCount;
      bool takingTurns = (diffInMoveCount == 1 || diffInMoveCount == 0 );
      
      return (validPlayers && takingTurns);
    }
    
    /// @author Robert Watkins
    /// @dev we will send a count of '1' if the pattern of player moves match values in the game state.
    ///      The matching value will default to 'unplayed' if the count is 0. Otherwise, the matching
    ///      player mark will be returned.
    function countIfMatching (uint256 playerMoveAtLocation1, uint256 playerMoveAtLocation2, uint256 playerMoveAtLocation3) view private returns (int, bytes1) {
        int count = 0;

        bytes1 matchingValue = unplayed;
        if (gameState[playerMoveAtLocation1] != unplayed) {
            if ((gameState[playerMoveAtLocation1] == xPlayer || gameState[playerMoveAtLocation1] == oPlayer) 
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
    function hasOnlyOneWinner() view private returns (bool, bytes1){

        bytes1 lastFoundWinner = unplayed;
        bytes1 matchingValue;
        int count;
        int totalWinnerCount = 0;
        (count, matchingValue) = countIfMatching(0,1,2);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(0,3,6);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(0,4,8);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(1,4,7);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(2,4,6);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(2,5,8);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(3,4,5);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        (count, matchingValue) = countIfMatching(6,7,8);
        if (count > 0) {lastFoundWinner = matchingValue;}
        totalWinnerCount += count;
        return (totalWinnerCount<=1,lastFoundWinner);
    }
    
    /// @author Robert Watkins
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O'.
    ///      Return a boolean indicating the game state is valid or not.
    function isValidGameState() view private returns (bool, bytes1){
        bool onlyOneWinner;
        bytes1 winner;
        (onlyOneWinner, winner) = hasOnlyOneWinner();
        bool validGame = validPlayersTakingTurns() && onlyOneWinner;
        return (validGame,winner);
    }

}


