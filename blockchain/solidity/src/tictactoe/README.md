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
This version will read from the stored version of the game state.
 - return: one of 'X', 'O', 'NONE', 'CAT' 
 - require: the game state must be valid

*function: makeMove*
 - param: player ('X' or 'O')
 - param: location on board for the move
 - return: the winner of the game to this point
 - require: the move must be valid

*function:; getGameState*
 - return: current game state

## Version 2
A player can start a game (where they play the 'O' player) or join someone that
has started the game. The joining player will be 'X'. 'X' goes first and play
alternates until the winner is not 'NONE'. 

Implement the following methods

*function: joinGame*
When 'X' joins the game, the game state and the players are reset, then the new player joining will be 'X'.
 - require: there is no game in progress. A game is in progress when both players have joined.

*function: getMyMark*
 - return: returns the message sender's mark. If the message sender is not a player, the 'NONE' mark is sent '0x0'

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

*function: reset*
 - This will reset the game to an 'unplayed' state to allow for recovery from abandoned games.
 - require: only the owner of the instance can initiate this function

## Running locally
*Pre-requisites*
 - Run private blockchain (like ganache)
 - Run remix http://remix.ethereum.org/
 -- deploy 'tictactoe.sol' to web3 provider HTTP://127.0.0.1:7545
 - Edit tictactoe ui (delivered as 'sketch.html')
 -- update gameAddress in 'sketch.html' to match deployed address from remix 
 - Run local webserver (like node http-server) where 'sketch.html' is able to be loaded

