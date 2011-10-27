-module(run).
-export([run_app/0]).

run_app() -> 
    http_utilities:start_inet(),
    http_utilities:print(http_utilities:get("www.sieson.com")),
    halt().
