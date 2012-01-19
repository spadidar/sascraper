-module(run).
-export([run_app/0, get_text/1, is_data/1]).

run_app() -> 
    main:start("",""),
    R = http_utils:get("http://www.tamale.net/erlang/tutorial.shtml"),
    D = element(3,R),
    T = mochiweb_html:tokens(D),
    get_text(T),
    halt().

get_text(Tokens) ->
    Printer = fun(E) -> is_data(E) end,
    lists:foreach(Printer, Tokens).
    
    
is_data(Data) ->
    case Data of
	<<Type, _, _>> ->
	    io:format("~p~n",[Type]);
	<<Type,_, _, _>> ->
	    io:format("~p~n",[Type]);
	<<Type,_,_, _, _>> ->
	    io:format("~p~n",[Type]);
	_ ->
	    false
    end.
    
