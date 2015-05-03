-module(cell_test). 
-on_load(test/0). 

test() -> 
  true = cellgroup:start({1,{0,0},0,not_cancerous,can_have_children}),   
  io:format("Start Succeeded~n"), 
  [{_Pid,{1,{0,0},0,not_cancerous,can_have_children}}] = cellgroup:show_cells(),
  io:format("Show Cells Suceeded~n"),
  %%{1,{0,0},0,not_cancerous,can_have_children} = Pid ! {request, self(), get_info}, 
  %%io:format("Get Info succeeded~n"), 
  %%cell:become_cancerous(), 
  %%io:format("Become cancerous succeeded~n"), 
  io:format("Done~n").
