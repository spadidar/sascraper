-module(run).
-export([run_app/0, 
	 print/1]).

run_app() -> 
    main:start("",""),
    R = http_utils:get("http://www.tamale.net/erlang/tutorial.shtml"),
    T = http_utils:parse_response(R),
    %% io:format("~p~n", [T]),
    http_utils:extract_text(T),
    %% http_utils:get_text(T),
    halt().

print(String) ->
    io:format(String ++ "~n" ).
