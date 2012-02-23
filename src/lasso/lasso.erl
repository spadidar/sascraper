-module(lasso).
-export([download/1, 
	 store_response/1,
	 scrape_urls/1,
	 scrape/3,
	 extract_urls/1
	]).

scrape(URL, Depth, Speed) ->
    .

scrape_urls(URL) ->
    case download(URL) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    extract_urls(ResponseBody). 
    end.

extract_urls(Response) ->
    RegExp = "href=[\"]?([^\">]+)",
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

store_response(Response) ->
    .

