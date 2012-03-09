-module(scraper).
-export([scrape/0]).

scrape()->
    Conn = db:mongo_connect(),
    Result = db:mongo_find(Conn, lasso, urls, {}),
    URLS = db:mongo_read(Result),
    Pid = spawn(lasso, recieve_jobs, ["www.yahoo.com"]),
    Pid ! "Test Brow",
    Pid ! stop
    %pass url to lasso one by one
    %lasso runs in threads 
.
