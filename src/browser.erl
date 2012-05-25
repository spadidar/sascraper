-module(browser).

-export([get/1,
	 post/1,
	 load/1
	]).

get(Url) ->
    httpc:request(Url).

post(Url) ->
    ibrowse:send_req(Url, [], get).

load(Url) ->
    ibrowse:send_req(Url, [], get).
