-module(main).
-behavior(application).
-export([start/2, 
	 stop/1,
	 start_apps/1,
	 stop_apps/1,
	 version/0
	]).


start_apps([]) ->
    ok;
start_apps([App|Rest]) ->
    case application:start(App) of
	ok ->
	    start_apps(Rest);
	{error, {already_started, App}} ->
	    start_apps(Rest);
	{error, _Reason} when App =:= public_key ->
	    start_apps(Rest);
	{error, _Reason} ->
	    {error, {app_would_not_start, App}}
    end.


stop_apps([]) ->
    ok;
stop_apps([App|Rest]) ->
    case application:stop(App) of
	ok ->
	    stop_apps(Rest);
	{error, {already_started, App}} ->
	    stop_apps(Rest);
	{error, _Reason} when App =:= public_key ->
	    stop_apps(Rest);
	{error, _Reason} ->
	    {error, {app_would_not_start, App}}
    end.

%% @doc Start the main process. Useful when testing using the shell. 
start(_Type, _Args) ->
    case start_apps([crypto, 
		     public_key, 
		     ssl, 
		     sasl, 
		     inets, 
		     lhttpc,
		     xmerl,
		     compiler,
		     syntax_tools,
		     ibrowse,
		     mochiweb,
		     mongodb]) of
        ok ->
	    ok;
        Error ->
            Error
    end.

%% @doc Stop the process. Useful when testing using the shell. 
stop(_State) ->
    case stop_apps([crypto, 
		    sasl, 
		    public_key, 
		    ssl, 
		    inets, 
		    ibrowse,
		    lhttpc,
		    xmerl,
		    compiler,
		    syntax_tools,
		    mochiweb,
		    mongodb]) of
        ok ->
	    ok;
        Error ->
            Error
    end.


%% @spec () -> Version
%%     Version = string()
%% @doc Return the version of the application.
version() ->
    {ok, Version} = application:get_key(scraper, vsn),
    Version.   
