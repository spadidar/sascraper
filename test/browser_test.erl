-module(browser_test).
-compile(export_all).
-include_lib("include/eunit/include/eunit.hrl").

get_test()->
    {ok, Result} = browser:get("www.yahoo.com"),
    io:format("Result ~n~s!", [Result]).
