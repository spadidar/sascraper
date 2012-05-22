-module(browser).

-export([get/1,
	 post/1,
	 load/1
	]).

get(Url) ->
    ibrowse:send_req(Url, [], get).
