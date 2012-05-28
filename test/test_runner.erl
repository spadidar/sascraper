-module(test_runner).
-export([run_tests/0]).

run_tests() -> 
    main:start("",""),
    test:passing_test(),
    io:format("Testing Scraper ~n"),
    %% test_scraper(),
    io:format("Testing Browser ~n"),
    test_browser(),
    halt().

test_browser() ->
    browser_test:get_test().

test_scraper() ->
    scraper_test:test_scrape().
