-module(scraper).
-export([scrape/0]).

scraper()->
    %get urls from mongo in batches
    %pass url to lasso one by one
    %lasso runs in threads 
    
.
