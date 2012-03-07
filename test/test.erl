-module(test).
-compile(export_all).
-include_lib("/usr/lib/erlang/lib/eunit-2.1.7/include/eunit.hrl").

passing_test() -> ?assert(true).

failing_test() -> ?assert(false).

run_app() -> 
    main:start("",""),
    halt().

