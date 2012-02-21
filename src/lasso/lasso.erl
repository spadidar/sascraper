-module(lasso).
-export([download/1, 
	 store_response/1,
	 scrape_urls/1,
	 scrape/1]).

scrape(URL) ->
    .

scrape_urls(URL) ->
    case download(URL) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    
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

