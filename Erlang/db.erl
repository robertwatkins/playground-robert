%%% File    : db.erl
%%% Author  : Francesco Cesarini <francesco@home.se>
%%% Purpose : Solution for Exercise 5, sequential programming
%%%           exercises. A database back end module
%%% Created : 10 Jan 2001 by Francesco Cesarini <francesco@home.se>

-module(db).
-author('francesco@home.se').

-export([new/0, write/3, delete/2, read/2, destroy/1]).

%% new() -> list().
%% Create a new database
new() -> 
    [].

%% insert(term(), term(), list()) -> list()
%% Insert a new element in the database
write(Key, Element, Db) -> 
    [{Key, Element}|Db].

%% delete(term(), list()) -> list()
%% Remove an element from the database
delete(Key, [{Key, _Element}|Db]) -> 
    Db;
delete(Key, [Tuple|Db]) ->
    [Tuple|delete(Key, Db)];
delete(_Key, []) ->
    [].

%% lookup(term(), list()) -> {ok, term()} | {error, instance}
%% Retrieve the first element in the database with a matching key
read(Key, [{Key, Element}|Db]) -> 
    {ok, Element};
read(Key, [_Tuple|Db]) ->
    read(Key, Db).

%% destroy(list()) -> ok.
%% Deletes the database. 

destroy(_Db) ->
    ok.
