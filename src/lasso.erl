-module(lasso).
-include("include/settings.hrl").
-export([download/1, 
	 scrape_urls/1,
	 scrape/2,
	 extract_urls/1,
	 queue_new_url/1,
	 receive_url/0
	]).

receive_url() ->
    receive
	{url, Url} ->
	    io:format("Got it ~p~n", [Url]);
	    %% scrape(U, D);
	stop ->
	    ture;
	_Other -> 
	    io:format("~p~n", [_Other]),
	    {error, unknown_msg}
    end.

scrape(URL, Depth) ->
    case extract_urls(URL) of 
	{match, URLS} ->
	    URLS;
	nomatch ->
	    nomatch
    end.

queue_new_url([]) -> [];
queue_new_url([URL|URLS]) ->
    Config = #mongo_creds{},
    db:mongo_insert(db:mongo_connect(), Config#mongo_creds.lasso_db, urls, {url,list_to_binary(URL)}),
    queue_new_url(URLS).

scrape_urls(URL) ->
    case download(URL) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    extract_urls(ResponseBody)
    end.

extract_urls(Response) ->
    RegExp = "href=[\\'\"]?([^\\'\" >]+)",
    Options = [],
    {ok, RE} = re:compile(RegExp),
    case re:run(Response, RE) of
	{match, Result} -> 
	    Result;
	nomatch -> 
	    nomatch
	end.


download(URL) ->
    case htt_utils:get(URL) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    {ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}};
	{error, Reason} ->
	    {error, Reason}
    end.


