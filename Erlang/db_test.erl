%%% File    : db_test.erl
%%% Author  :  <francesco@erlang-consulting.com>
%%% Description : Test Suite for the db module.

-module(db_test).
-compile(export_all).



test() ->
    test(1, noState).

test(TestNo, State) ->
    Function = list_to_atom([$t|integer_to_list(TestNo)]),
    case (catch apply(?MODULE, Function, [State])) of
	{'EXIT', {undef, [{?MODULE, Function, _}|_]}} ->
	    io:format("~nAll tests Completed successfully.~n"); 
	{'EXIT', Reason} ->
	    io:format("Test:~w failed with Reason:~p~n",[TestNo, Reason]),
	    io:format("~nAborting Test Suite~n");
	NewState ->
	    io:format("Test:~w successful. New State:~p~n",[TestNo, NewState]),
	    test(TestNo+1, NewState)
    end.


t1(State) ->
    Db = db:new().

t2(State) ->
    db:write(francesco, london, State).

t3(State) ->
    {ok, london} = db:read(francesco, State),
    State.

t4(State) ->
    db:write(lelle, stockholm, State).

t5(State) ->
    {ok, london} = db:read(francesco, State),
    State.

t6(State) ->
    db:delete(lelle, State).

t7(State) ->
    {error, instance} = db:read(lelle, State),
    State.

t8(State) ->
    db:delete(lelle, State).

t9(State) ->
    {ok, london} = db:read(francesco, State),
    State.

t10(State) ->
    ok = db:destroy(State).