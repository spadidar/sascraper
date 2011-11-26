-module(db_manager).
-include("include/settings.hrl").

connect() ->
    Options = [{basic_auth, {#db_creds.user_name, #db_creds.password}}],
    http_utilities:print(#db_creds.host),
    Server = couchbeam:server_connection(#db_creds.host, #db_creds.port, #db_creds.prefix, Options).
