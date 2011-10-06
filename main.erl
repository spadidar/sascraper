-module(main).

-import(http_utilities, [start_inet/0]).
-export([run/0]).

run() -> 
    start_inet(),
    http_utilities:get("www.sieson.com").
    
