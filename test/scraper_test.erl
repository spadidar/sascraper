-module(scraper_test).
-compile(export_all).
-include_lib("include/eunit/include/eunit.hrl").

prepare() ->
    C = db:mongo_connect(),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("www.bbc.co.uk/news")),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("http://www.reddit.com/")),
    db:mongo_insert(C, test_lasso, urls, list_to_binary("http://news.ycombinator.com/")).

test_scrape() ->
    scraper:scrape("http://www.reddit.com/").
