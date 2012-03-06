-module(scraper).
-export([scrape/0]).

scraper()->
    Conn = db:mongo_connect(),
    Result = mongo_find(Conn, lasso, urls, {}),
    URLS = db:mongo_read(Result)

    %pass url to lasso one by one
    %lasso runs in threads 
.
