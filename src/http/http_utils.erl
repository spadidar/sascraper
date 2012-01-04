-module(http_utils).

-export([get/1, get/4,
	 prepare_url/1,
	 print/1,
	 parse_response/1]).

get(Raw_Url) ->
    Headers = [], 
    Timeout = 30000,
    get(Raw_Url, "GET", Headers, Timeout).

get(Raw_Url, Method ,Headers, Timeout) ->
    URL = prepare_url(Raw_Url),
    print("Getting " ++ URL),
    case lhttpc:request(URL, Method, Headers, Timeout) of
	{ok, {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody}} ->
	    {{StatusCode, ReasonPhrase}, Hdrs, ResponseBody};
	{error, Reason} ->
	    {error, Reason}
	end.

prepare_url(URL) ->
    case re:run(URL,"http://", [{capture, none}]) of 
	nomatch -> "http://" ++ URL;
	match -> URL
    end.

parse_response(Response) ->
    mochiweb_html:parse(element(3, Response)).
		

print(String) ->
    io:format(String ++ "~n" ).
