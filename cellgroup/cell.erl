-module(cell). -export([split/0,become_cancerous/0,get_info/0,start/1]). -export([init/1]). 

%% handle client calls 
init(Data)         -> loop(Data). 
start(Data)        -> init(Data). %%_Pid = spawn(cell, init, [Data])). 

become_cancerous() -> call(become_cancerous). 
get_info()         -> call(get_info). 
split()            -> call(split). 

call(Message) -> 
  self() ! {request, self(), Message}, 
  receive 
    {reply, Reply} -> Reply 
  end. 

reply(Pid, Reply) -> 
  Pid ! {reply, Reply}. 

loop(Data) -> 
  cellgroup:split(one),
  receive 
    {request, Pid, become_cancerous} -> 
      {TempData, _Reply} = become_cancerous(Data, Pid), 
      reply(Pid, TempData), loop(TempData); 
    {request, Pid, get_info} -> 
      {Data, _Reply} = get_info(Data, Pid), 
      reply(Pid,Data), 
      loop(Data); 
    {request, Pid, split} -> 
      {TempData, _Reply} = split(Data, Pid), 
      reply(Pid, TempData), 
      loop(TempData) 
end. 

become_cancerous(Data,_Pid) ->  
  {Key,Location,Generation,_Cancer_State,Reproductive_State} = Data, 
  TempData = {Key,Location,Generation,cancerous,Reproductive_State}, 
  {TempData, ok}. 

get_info(Data, _Pid)-> 
  {Data, ok}. 

split(Data, _Pid) ->   
  {Key,Location,Generation,Cancer_State,_Reproductive_State} = Data, 
  cellgroup:split(Key), 
  TempData = {Key, Location, Generation+1,Cancer_State, has_children},   
  {TempData, ok}.
