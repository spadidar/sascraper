-module(db).
-include("include/settings.hrl").

-export([couch_connect/0,
	 couch_create_db/2,
	 mongo_connect/0,
	 mongo_disconnect/1,
	 mongo_insert/4,
	 mongo_find/4,
	 mongo_read/1,
	 mongo_delete/2
	]).

couch_connect() ->
    Creds = #db_creds{},
    Options = [{basic_auth, {Creds#db_creds.user_name, Creds#db_creds.password}}],
    Server = couchbeam:server_connection(Creds#db_creds.host, Creds#db_creds.port, Creds#db_creds.prefix, Options),
    Server.

couch_create_db(Name, Server) ->
    case couchbeam:create_db(Server, Name, [], []) of
	{ok, _Status, _Headers, _Body} -> ok;
	{error, {ok, "412", _, _}} -> error;
	Error -> Error
    end.

mongo_connect() ->
    Creds = #mongo_creds{},
    {ok, Conn} = mongo:connect({Creds#mongo_creds.host, Creds#mongo_creds.port}),
    Conn.
    
mongo_disconnect(Conn) ->
    ok = mongo:disconnect(Conn).
    
mongo_insert(Conn, DB, Collection, Data) ->
    case mongo_connect:is_closed(Conn) of
	false -> 
	    mongo:do(safe, master, Conn, DB, fun() -> mongo:insert(Collection, Data) end);
	true ->
	    mongo:do(safe, master, mongo_connect(), DB, fun() -> mongo:insert(Collection, Data) end)
    end.

mongo_find(Conn, DB, Collection, Data) ->
    case mongo_connect:is_closed(Conn) of
	false -> 
	    mongo:do(safe, master, Conn, DB, fun() -> mongo:find(Collection, Data) end);
	true ->
	    mongo:do(safe, master, mongo_connect(), DB, fun() -> mongo:find(Collection, Data) end)
    end.

mongo_read(Result) ->
    case Result of 
	{ok, Docs} -> mvar:read(Docs);
	{error, _} -> error
    end.

mongo_delete(Collection, Selector) ->
    mongo:delete(Collection, Selector).
