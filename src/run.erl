-module(run).
-export([run_app/0]).

run_app() -> 
    main:start("",""),
    R = http_utils:get("http://tamale.net/erlang/tutorial.shtml"),
    D = element(3,R),
    T = mochiweb_html:tokens(D),
    get_text(T),
    io:format("~w~n",[T]),
    halt().

get_text(Tokens) ->
    Printer = fun(E) -> io:format("~p~n",[E]) end,
    lists:foreach(Printer, Tokens).
    
    
