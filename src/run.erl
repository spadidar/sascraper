-module(run).
-export([run_app/0]).

run_app() -> 
    main:start("",""),
    downloader:download("www.bbc.co.uk"),
    %% Server = db_manager:connect(),
    %% couchbeam:create_db(Server, "sasandzc", [], []),
    %% http_utilities:print("connected"),
    halt().
