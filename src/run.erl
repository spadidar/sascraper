-module(run).
-export([run_app/0]).

run_app() -> 
    application:start(sasl),
    application:start(ibrowse),
    application:start(couchbeam),
    couchbeam:open_db(Server, "testdb", Options),
    couchbeam:server_info(Server),
    couchbeam:create_db(Server, "testdb", Options).

    %% http_utilities:start_inet(),
    %% http_utilities:print(http_utilities:get("www.sieson.com")),
    halt().
