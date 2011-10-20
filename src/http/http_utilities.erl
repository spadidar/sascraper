-module(http_utilities).

-export([start_inet/0,
	 get/1,
	 prepare_url/1]).

start_inet()->
    case inets:services_info() of
	{error,inets_not_started} -> inets:start()
    end.

get(Raw_Url) ->
    URL = prepare_url(Raw_Url),
    print("Getting " ++ URL),
    { ok, {Status, Headers, Body }} = http:request(URL),
    Body.

prepare_url(URL) ->
    case re:run(URL,"http://", [{capture, none}]) of 
	nomatch -> "http://" ++ URL;
	match -> URL
    end.

print(String) ->
    io:format(String ++ "~n" ).
