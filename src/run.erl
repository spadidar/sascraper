-module(run).
-export([run_app/0, 
	 print/1, funcx/1]).

run_app() -> 
    main:start("",""),
    R = http_utils:get("http://www.tamale.net/erlang/tutorial.shtml"),
    file:write_file("./response.txt", io_lib:fwrite("~p.\n", [R])),
    T = http_utils:parse_response(R),
    Text = http_utils:extract_text(T),
    io:format("~p~n", [Text]),
    %% F = file_utils:readlines("./response.txt"),
    %% io:format("~p~n", [F]),
    %% io:format("~p~n", [T]),
    %% http_utils:get_text(T),
    halt().

print(String) ->
    io:format(String ++ "~n" ).


%% ---------Test
funcx([]) -> 
    io:format("~p~n", ["0"]); 
funcx([S|Ss]) -> 
    io:format("~p~n", [S]),
    funcx(Ss).    
