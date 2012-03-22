-module(scraper_test).
-compile(export_all).
-include_lib("include/eunit/include/eunit.hrl").

prepare() ->
    C = db:mongo_connect(),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("www.bbc.co.uk/news")),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("")),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("www.bbc.co.uk/news")).
