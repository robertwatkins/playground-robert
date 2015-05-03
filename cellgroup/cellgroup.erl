-module(cellgroup).
-export([start/1,split/1,get_sphere_of_interest/1,turn_cancerous/2,show_cells/0]).
-export([init/1]).

init(Data) ->
 Pid = spawn(cell,start,[Data]),
 Cells = [{Pid, Data}],
 loop(Cells).
 
%% Public Functions 
start(Data) ->
 register(cellgroup, spawn(cellgroup, init, [Data])).
 
split(Key)                    -> call({split, Key}).
get_sphere_of_interest(Key)   -> call({get_sphere_of_interest,Key}).
turn_cancerous(FromKey,ToKey) -> call({turn_cancerous,FromKey,ToKey}).
show_cells()                  -> call({show_cells}).
 
%% Internal Functions 
 call(Message) -> 
  cellgroup ! {request, self(), Message}, 
  receive 
    {reply, Reply} -> Reply 
  end. 

reply(Pid, Reply) -> 
  Pid ! {reply, Reply}. 
  
loop(Cells) ->
  receive
    {request, Pid, {show_cells}} ->
      reply(Pid, Cells),
      loop(Cells);
    {request, Pid, {split, Key}} ->
      Cell = split(Key, Cells, Pid),
      TempCells = [Cell|Cells],
      reply(Pid,{TempCells, Cell}),
      loop(TempCells); 
    {request, Pid, {get_sphere_of_interest,Key}} ->
      {TempCells, _Reply} = get_sphere_of_interest(Key,Cells,Pid ), 
      reply(Pid,TempCells), 
      loop(Cells);
    {request, Pid, {turn_cancerous, FromKey, ToKey}} ->
      {Cells, _Reply} = turn_cancerous(FromKey, ToKey, Cells, Pid),
      reply(Pid,ok),
      loop(Cells)
  end.


split(_Key, _Cells, _Pid) ->
  Data = {1,{0,0},0,not_cancerous,can_have_children},
  Pid = spawn(cell, start, [Data]),
  {Pid,Data}.
  
get_sphere_of_interest(_Key, _Cells, _Pid) ->
  [].
  
turn_cancerous(_FromKey, _ToKey, _Cells, _Pid) ->
  [].
