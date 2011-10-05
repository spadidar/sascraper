-module(http_utilities).

-export([start_inet/0,
	 get/1]).

start_inet()->
    inets:start().

get(URL) ->
    io:format("Get " ++ URL ++ "~n" ),
    { ok, {Status, Headers, Body }} = http:request(URL),
    Body.

