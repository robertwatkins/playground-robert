-module(my_db).
-export([start/0, write/2, read/1, update/2]).
-export([init/0]).

start() ->
  register(my_db, spawn(my_db,init, [])).

init() ->
  Data = {get_data(), []},
  loop(Data).


get_data()-> [].

%%Client Functions

write (Key, Element)     -> call({write, Key, Element}).
read (Key)               -> call({read, Key}).
update (Key, Element)    -> call({update, Key, Element}).

%% Hide all message passing in a functional interface


call(Message) ->
    my_db ! {request, self(), Message},
    receive
      {reply, Reply} -> Reply
    end.

%% Main Loop

loop(Data) ->
  receive
    {request, Pid, {write, Key, Element}} ->
       {NewData, Reply} = write(Key, Element, Data),
       reply(Pid, Reply),
       loop(NewData);   
   {request, Pid, {read, Key}} ->
       {NewData, Element} = read(Key,Data),
       reply(Pid,Element),
       loop(NewData);
   {request, Pid, {update, Key, Element}} ->
        {NewData, Reply} = update(Key, Element, Data),
        reply(Pid, Reply),
        loop(NewData)
  end.


reply(Pid, Reply) ->
  Pid ! {reply, Reply}.

%% Internal functions to read/write/delete data

write(Key, Element, Data) ->
  {[{Key,Element}|Data],{ok,write_succeeded}}.
read(Key, [{Key,Element}|_]) ->
  {Element,{ok,Element}};
read(Key, [_Tuple|Data])->
  read(Key, Data).
update(Key, Element, [{Key, _ }| Data])->
  {[{Key, Element}|Data],{ok,update_succeeded}};
update(Key, Element, [TempElement|Data]) ->
  update (Key, Element, [Data|TempElement]).
 