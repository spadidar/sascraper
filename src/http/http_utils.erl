-module(http_utils).

-export([get/1, get/4,
	 prepare_url/1,
	 extract_text/1, 
	 extract_text/2,
	 get_data/1,
	 parse_response/1]).

get(Raw_Url) ->
    Headers = [], 
    Timeout = 30000,
    get(Raw_Url, "GET", Headers, Timeout).

get(Raw_Url, Method ,Headers, Timeout) ->
    URL = prepare_url(Raw_Url),
    io:format("Getting " ++ URL ++ "~n"),
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
    Body = element(3,Response),
    Tokens = mochiweb_html:tokens(Body),
    Tokens.

extract_text(Tokens) ->
    extract_text(Tokens, []).

extract_text([], Acc) -> 
    Acc;
extract_text([T|Ts], Acc) ->
    case get_data(T) of
	false ->
	    extract_text(Ts, Acc);
	{body, Body} ->
	    io:format("Body>> ~p~n", [Body]),
	    extract_text(Ts,[bitstring_to_list(Body)|Acc])
	    %% lists:append(bitstring_to_list(Body), bitstring_to_list(extract_text(Ts)))
    end.
			     
			        
    %% Printer = fun(E) -> get_data(E) end,
    %% lists:foreach(Printer, Tokens).

clean_data(String) ->
    String.


get_data(Data) ->
    case Data of
	{data, Body, _} ->
	    {body, Body};
	{start_tag, Tag, _, _} ->
	    %% io:format("Start: ~p~n",[Tag]),
	    false;
	{end_tag, Tag} ->
	    %% io:format("End: ~p~n",[Tag]),
	    false;
	_ ->
	    false
    end.

