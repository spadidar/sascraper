-module(run).
-export([run_app/0]).

run_app() -> 
    %% downloader:download("www.bbc.co.uk"),
    main:start("",""),
    R = http_utils:get("http://tamale.net/erlang/tutorial.shtml"),
    D = element(3,R),
    T = mochiweb_html:tokens(D),
    halt().

get_text(Data) ->
    lists:foreach(Funn,T).
