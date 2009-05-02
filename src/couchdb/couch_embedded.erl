-module(couch_embedded).
-author("=Bill.Barnhill").


-export([start/0, start/1, start/2]).
-export([dbopen/2, dbopen/3, list/1]).

-include("couch_db.hrl").

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


dbopen(DbName, InitialDocs) ->
	dbopen(DbName, InitialDocs, []).
	

dbopen(DbName, InitialDocs, InitialDocOptions) ->
	case couch_server:open(DbName) of
		{ok, Db} = R ->
			error_logger:info_msg("Db '~s' exists and is open, main pid is ~p", [DbName, Db]),  
			R;
		not_found ->
			case couch_server:create(DbName, []) of
				{ok, Db} = R ->
						error_logger:info_msg("Db '~s' created  and is open, main pid is ~p", [DbName, Db]),  
						error_logger:info_msg("Created initial docs"),
						couch_db:save_docs(Db, InitialDocs, InitialDocOptions),
						error_logger:info_msg("Created following docs: ~p", [InitialDocs]),
						R;
				{error, Reason} ->
					Msg = io_lib:format("Unable to create couchdb database named '~s' [~p]", [DbName, Reason]),
					error_logger:error_msg(Msg),
					{error, db_unavailable, Msg}
			end;				
		{error, Error} -> 
					Msg = io_lib:format("Unable to open couchdb database named '~s' [~p]", [DbName, Error]),
					error_logger:error_msg(Msg),
					{error, db_unavailable, Msg}
	end.


list(Db) ->
	DumpFn = fun(#full_doc_info{id=Id}=Info, _Offset, Acc) ->
		Doc = couch_db:open_doc(Db, Id),
		error_logger:info_msg("==Doc Info for '~p'==~n~p~n",[Id, Info]),
		error_logger:info_msg("==Doc for '~p'==~n~p~n~n",[Id, Doc]),
		{ok, Acc}
	end,
	couch_db:enum_docs(Db, 0, DumpFn, Db).
