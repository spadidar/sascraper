-module(string_utils).
-export([sub/3,gsub/3,subst/4]).

sub(Str,Old,New) ->
    Lstr = string:len(Str),
    Lold = string:len(Old),
    Pos  = string:str(Str,Old),
    if 
	Pos =:= 0 -> 
	    Str;
	true      ->
	    LeftPart = string:left(Str,Pos-1),
	    RitePart = string:right(Str,Lstr-Lold-Pos+1),
	    string:concat(string:concat(LeftPart,New),RitePart)
    end.

gsub(Str,Old,New) ->
    Acc = sub(Str,Old,New),
    subst(Acc,Old,New,Str).

subst(Str,_Old,_New, Str) -> Str;
subst(Acc, Old, New,_Str) ->
    Acc1 = sub(Acc,Old,New),
    subst(Acc1,Old,New,Acc).
