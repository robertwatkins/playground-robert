pragma solidity ^0.4.0;

/// @title tictactoe
/// @author Robert Watkins
/// @notice An experiment in writing Solidity
contract tictactoe {
    address owner;
    address xPlayerAddress;
    address oPlayerAddress;
    bytes9 gameState;
    bytes9 nextPlayerMark;
    
    
    // Players and Winner Options
    bytes1 constant xPlayerMark = 0x11;
    bytes1 constant oPlayerMark = 0xAA;
    bytes1 constant unplayedMark = 0x00;
    bytes1 constant catMark = 0xFF;
    address constant noAddress = 0x0;
    bytes9 constant gameWithNomoves =  0x000000000000000000;
        
    constructor() payable public{
        owner = msg.sender;
        xPlayerAddress = noAddress;
        oPlayerAddress = noAddress;
        gameState = gameWithNomoves;
        nextPlayerMark = xPlayerMark;
    }

    /// @author Robert Watkins
    /// @notice If there is no game in progress, you will be assigned either the 'X' or 'O' mark for the game.
    /// @dev By convention we will use '0x11' for 'X' and '0xAA' for 'O'
    ///      There is nothing preventing the same person playing both 'X' and 'O'
    function joinGame() payable public {
        require (!gameInProgress(),"There is a game in progress. Please wait until that game is complete before joining.");
        if (xPlayerAddress == noAddress) {
            xPlayerAddress = msg.sender;
        } else if (oPlayerAddress == noAddress) {
            oPlayerAddress = msg.sender;
        } else {
            revert("The game already has enough players.");
        }
        
    }
    
    /// @author Robert Watkins
    /// @notice Return the mark of the message sender.
    /// @dev By convention we will use '0x11' for 'X', '0xAA' for 'O' and '0x0' for 'Not a player'
    ///      There is a side-effect that if the same player is both 'X' and 'O', only the 'X' mark is returned
    function getMyMark() view public returns (bytes1){
        if (msg.sender == xPlayerAddress) {
            return xPlayerMark;
        }
        
        if (msg.sender == oPlayerAddress) {
            return oPlayerMark;
        }
        
        return unplayedMark;
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
        
        if (winner == unplayedMark){
            bool isCatWinner = true; 
            uint i;
            for (i=0; i<9; i++){
                isCatWinner = (isCatWinner && (gameState[i] != unplayedMark));
            }
            if (isCatWinner) {winner = catMark;}
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
    function makeMove(uint256 moveLocation) payable public {
        
        require (isValidPlayer(msg.sender),"Invalid Player");
        require (isValidMoveLocation(moveLocation), "Invalid Move");
        bytes1 playerMakingMove = getPlayerMark(msg.sender);
        nextPlayerMark = playerAfter(playerMakingMove);
        //create an empty game and add the players move in location, 
        //then use bitwise 'or' to modifiy the gamestate
        bytes9 moveMask = playerMakingMove >> (moveLocation * 8);
        gameState = gameState | moveMask;
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
    /// @return the mark associated with the message sender (if any)
    /// @dev By convention we will use '0x00' for a space not played, '0x11' for 'X' and '0xAA' for 'O', '0x0' for 'Not a player' 
    function getPlayerMark(address playerAddress) view private returns (bytes1){
        if (playerAddress == xPlayerAddress) {
            return xPlayerMark;
        }
        if (playerAddress == oPlayerAddress) {
            return oPlayerMark;
        }
        return unplayedMark;
    }
    
    /// @notice list the players
    /// @dev by convention, X is listed first 
    function listPlayers() view public returns (address[2]){
        return [xPlayerAddress,oPlayerAddress];
    }
    
    
    /// @author Robert Watkins
    /// @notice returns a boolean 'False' if there is no game in progress and 'True' if there is a game in progress
    function gameInProgress() view private returns (bool) {
        bool isGameInProgress = (gameState != gameWithNomoves ) 
                             || ((gameState == gameWithNomoves) && (xPlayerAddress != noAddress) && (oPlayerAddress != noAddress));
        return isGameInProgress;
    }
    
    /// @author Robert Watkins
    /// @notice returns the player to play next, based on the current player
    function playerAfter(bytes9 player) pure private returns (bytes1) {
        if (player== xPlayerMark) {
            return oPlayerMark;
        } else {
            return xPlayerMark;
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
        validMove = (gameState[location] == unplayedMark);
        return validMove;
    }
    
    /// @author Robert Watkins
    /// @notice validate that the player making the move is an X or O and it's their turn 
    function isValidPlayer(address playerAddress) view private returns (bool){
        bytes1 player = getPlayerMark(playerAddress);
        bool validPlayer;
        validPlayer = (player == nextPlayerMark)
                      && ((player == xPlayerMark)||(player == oPlayerMark));
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
        if (currentSpaceValue == xPlayerMark) {xPlayerCount++;}
        if (currentSpaceValue == oPlayerMark) {oPlayerCount++;}
        validPlayers = (validPlayers && (currentSpaceValue == xPlayerMark || currentSpaceValue == oPlayerMark || currentSpaceValue == unplayedMark) );
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

        bytes1 matchingValue = unplayedMark;
        if (gameState[playerMoveAtLocation1] != unplayedMark) {
            if ((gameState[playerMoveAtLocation1] == xPlayerMark || gameState[playerMoveAtLocation1] == oPlayerMark) 
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

        bytes1 lastFoundWinner = unplayedMark;
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



