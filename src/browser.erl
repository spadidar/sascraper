-module(browser).

-export([get/1
	]).

get(Raw_Url) ->
    Url = prepare_url(Raw_Url),
    io:format("Getting " ++ Url ++ "~n"),
    case httpc:request(Url) of 
	{ok, Result} -> {ok, element(3,Result)};
	{error, Reason} -> {error, Reason}
    end.

prepare_url(URL) ->
    case re:run(URL,"http://", [{capture, none}]) of 
	nomatch -> "http://" ++ URL;
	match -> URL
    end.

