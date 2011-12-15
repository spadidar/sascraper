-module(run).
-export([run_app/0]).

run_app() -> 
    application:start(sasl),
    application:start(ibrowse),
    application:start(couchbeam),
    %% Host = "localhost",
    %% Port = 5984,
    %% Prefix = "",
    %% UserName = "admin", 
    %% Password = "sasan",
    %% Options = [{basic_auth, {UserName, Password}}],
    %% Server = couchbeam:server_connection(Host, Port, Prefix, Options),
    %% couchbeam:server_info(Server) ,
    %% couchbeam:create_db(Server, "radandb", [], []),
    Server = db_manager:connect(),
    couchbeam:create_db(Server, "sasandzc", [], []),
    http_utilities:print("connected"),
    %% http_utilities:start_inet(),
    %% http_utilities:print(http_utilities:get("www.sieson.com")),
    halt().
