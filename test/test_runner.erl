-module(test_runner).
-export([run_tests/0]).

run_tests() -> 
    main:start("",""),
    halt().
