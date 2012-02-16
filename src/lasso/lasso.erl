-module(lasso).
-export([download/1, store_response/1]).

download(URL) ->
    case htt_utils:get(URL) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    ResponseBody;
	{error, Reason} ->
	    {error, Reason}
    end.

store_response(Response) ->
    .

