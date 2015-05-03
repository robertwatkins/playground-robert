-module(my_db_test).
-on_load(test/0).

test() ->
true = my_db:start(),
{ok,write_succeeded} = my_db:write(1,one),
{ok,write_succeeded} = my_db:write(2,three),
{ok,update_succeeded} = my_db:update(2,two),
{ok,two} = my_db:read(2),
{ok,one} = my_db:read(1),
io:format("Done~n").

