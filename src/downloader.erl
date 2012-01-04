-module(downloader).

-export([download/1
]).

download(URL) ->
    Response = http_utils:get(URL),
    http_utils:parse_response(Response).
    
