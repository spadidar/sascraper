-module(db_manager).

connect() ->
    Host = "localhost",
    Port = 5984,
    Prefix = "",
    UserName = "admin", 
    Password = "sasan",
    Options = [{basic_auth, {UserName, Password}}],
    Server = couchbeam:server_connection(Host, Port, Prefix, Options),
