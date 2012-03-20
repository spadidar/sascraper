-module(test).
-compile(export_all).
-include_lib("include/eunit/include/eunit.hrl").

passing_test() -> ?assert(true).

failing_test() -> ?assert(false).

run_app() -> 
    main:start("",""),
    halt().

