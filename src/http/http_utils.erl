-module(http_utils).

-export([get/1, get/4,
	 prepare_url/1,
	 extract_text/1, 
	 get_text/1, 
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

extract_text([]) ->
    [];
extract_text([T|Ts]) ->
    case get_data(T) of
	false ->
	    io:format("S: ~p~n", [Ts]),
	    extract_text(Ts),
	    io:format("False: ~p~n", [T]);
	{body, Body} ->
	    io:format("TRue: ~p~n", [Body]),
	    lists:append(Body, extract_text(Ts))
    end.
			     
			        
    %% Printer = fun(E) -> get_data(E) end,
    %% lists:foreach(Printer, Tokens).

get_text([]) ->
    false.

get_data(Data) ->
    case Data of
	{data, Body, _} ->
	    io:format("~p~n",[Body]),
	    {body, Body};
	%% {Type, _, _} ->
	%% 	io:format("~p~n",[Type]);
	%% {Type,_, _, _} ->
	%% 	io:format("~p~n",[Type]);
	%% {Type,_,_, _, _} ->
	%% 	io:format("~p~n",[Type]);
	_ ->
	    false
    end.

