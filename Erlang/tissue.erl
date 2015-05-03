-module(tissue).
-export([split/1, turn_cancerous/1, cell_age/1, parent_of/1, sphere_of_interest/1]).
-export([init/0]).

init() ->
  gb_trees:start().

split(Cell) ->
  gb_trees:add(Cell).


turn_cancerous(Cell) ->
  gb_trees:update(Cell).


cell_age(Cell) ->
  Cell.

parent_of(Cell) ->
  Cell.

sphere_of_interest(Cell) ->
  Cell.
