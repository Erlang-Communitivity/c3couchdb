-module(couch_embedded).
-author("=Bill.Barnhill").


-export([start/0, start/1, start/2]).

-define(DEFAULT_PORT, 5984).
-define(DEFAULT_DATADIR, "./data").

start() ->
	start(?DEFAULT_DATADIR).

start([A | _Rest] = DataDir) when is_integer(A) ->
	start(DataDir, ?DEFAULT_PORT).

start([A | _Rest] = DataDir, Port) when is_integer(A), is_integer(Port) ->
	application:start(crypto),
	application:start(inets),
	application:start(mochiweb),
	application:load(couch),
	application:set_env(couch, {"Couch","DbRootDir"}, DataDir),
	application:set_env(couch, {"Couch","Port"}, Port),
	couch_server:start().



