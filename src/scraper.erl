-module(scraper).
-export([scrape/1,
	run_scraper/0]).

run_scraper() ->
    Conn = db:mongo_connect(),
    Result = db:mongo_find(Conn, lasso, urls, {}),
    URLS = db:mongo_read(Result).
    
scrape(Url)->
    Pid = spawn(lasso, receive_url, [Url]),
    Pid ! "Test Brow",
    Pid ! stop
    %pass url to lasso one by one
    %lasso runs in threads 
.
