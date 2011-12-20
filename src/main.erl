-module(main).
-behavior(application).
-export([start/2, 
	 stop/1,
	 start_apps/1,
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


%% @doc Start the main process. Useful when testing using the shell. 
start(_Type, _Args) ->
    case start_apps([crypto, sasl, ssl, ibrowse, couchbeam]) of
        ok ->
	    ok;
        Error ->
            Error
    end.

%% @doc Stop the process. Useful when testing using the shell. 
stop(_State) ->
    application:stop(couchbeam),
    application:stop(ibrowse),
    application:stop(crypto).


%% @spec () -> Version
%%     Version = string()
%% @doc Return the version of the application.
version() ->
    {ok, Version} = application:get_key(scraper, vsn),
    Version.   
