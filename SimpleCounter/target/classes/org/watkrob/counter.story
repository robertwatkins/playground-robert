Narrative:
In order to track points for a game
As a game player
I want to be able to increment/decrement/set a counter.

Scenario: Initialize the counter
Given I have just initialized the counter
Then the value is 0

Scenario: Using the 'add1' function raises the counter by 1
Given I have a counter with a value of 3
When I use the 'add1' function
Then the value is 4

Scenario: Using the 'subtract1' function reduces the counter by 1
Given I have a counter with a value of 10
When I use the 'subtract1' function
Then the value is 9

Scenario: Using the 'add1' function when the counter is at the largest integer value has no effect on the counter
Given I have a counter with a value of Integer.MAX_VALUE
When I use the 'add1' function
Then the value is Integer.MAX_VALUE

Scenario: Using the 'subtract1' function when the counter is 0 has no effect on the counter
Given I have a counter with a value of 0
When I use the 'subtract1' function
Then the value is 0

