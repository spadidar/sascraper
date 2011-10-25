-module(main).
-behavior(application).
-export([start/2, stop/1]).

start(_Type, _Args) ->
    http_utilities:start_inet(),
    http_utilities:get("www.sieson.com"),
    http_utilities:print("sasan"),
    ok.
stop(_State) ->
    ok.
    
