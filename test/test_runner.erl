-module(test_runner).
-export([run_tests/0]).

run_tests() -> 
    main:start("",""),
    test:passing_test(),
    scraper_test:test_scrape().

    %% halt().
