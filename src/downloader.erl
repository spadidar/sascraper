-module(downloader).

-export([download/1
]).

download(URL) ->
    html = http_utils:get(URL),
    http_utils:parse_response(html).
    
