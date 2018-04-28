# Blockchain tictactoe

This project will be to implement a game of tictactoe using Ethereum to manage
the game state and javascript/html for the UI.

## Version 0
A player can submit a game state and get a response back of whether there is a
winner, who the winner is or if the game is over with no winner "Cat's Game".
If the game state is valid, the response will be a message indicating so. There
is no sense of 'turn' or who has 'X' and who has 'O' in this version.

Implement the following method
*function: showWinner*
 - param: game state 
 - return: one of 'X', 'O', 'NONE', 'CAT' 
 - require: the game state must be valid

## Version 1
A player can submit a move, but it must be in order. X always goes first and
gameplay continues until the winner is other than 'NONE'. Once a winner is
determined, the next valid move resets the game state. In this version, there
is no sense that only one person can play for 'X' and one can play for 'O'.
When a move is made, the response is either a rejection of the move for invalid
moves or the result of the 'showWinner' function as described above.

Implement the following methods

*function: showWinner*
 - param: game state 
 - return: one of 'X', 'O', 'NONE', 'CAT' 
 - require: the game state must be valid

*function: makeMove*
 - param: player ('X' or 'O')
 - param: location on board for the move
 - return: the winner of the game to this point
 - require: the move must be valid

## Version 2
A player can start a game (where they play the 'O' player) or join someone that
has started the game. The joining player will be 'X'. 'X' goes first and play
alternates until the winner is not 'NONE'. 

Implement the following methods

*function: playGame*
 - return: one of 'X' or 'O'. The first player to join will be 'O' the second will be 'X' 
 - require: there is no game in progress. A game is in progress when both players have joined.

*function: makeMove*
 - param: location on board for the move
 - return: the winner of the game to this point
 - require: the move must be valid, it must be the proper user's turn, the requester must be one of the players in the current game.

*function: getGameState*
 - return: the game state

*function: getPlayers*
- return: the current player list

*function: showWinner*
 - param: game state 
 - return: one of 'X', 'O', 'NONE', 'CAT' 
 - require: the game state must be valid

*function: whoseTurn*
 - return: the player whose turn it is
 - require: there is a game in progress

## Version 3
Create a Javascript UI to interact with the game built in version 2 using a browser and the 'metamask' browser extension

