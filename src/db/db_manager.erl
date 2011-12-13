-module(db_manager).
-include("include/settings.hrl").

-export([connect/0
	]).

connect() ->
    Creds = #db_creds{},
    Options = [{basic_auth, {Creds#db_creds.user_name, Creds#db_creds.password}}],
    Server = couchbeam:server_connection(Creds#db_creds.host, Creds#db_creds.port, Creds#db_creds.prefix, Options),
    Server.
