-module(downloader).

-export([download/1
]).

download(URL) ->
    Html = http_utils:get(URL),
    HtmlBitString = element(3, Html),
    http_utils:parse_response(HtmlBitString).
    
