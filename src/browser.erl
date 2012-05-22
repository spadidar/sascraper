-module(browser).

-export([get/1,
	 post/1,
	 load/1
	]).

get(Url) ->
    ibrowse:send_req(Url, [], get).

post(Url) ->
    ibrowse:send_req(Url, [], get).

load(Url) ->
    ibrowse:send_req(Url, [], get).
