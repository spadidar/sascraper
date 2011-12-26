-module(test).
-compile(export_all).
-include_lib("/usr/lib/erlang/lib/eunit-2.1.7/include/eunit.hrl").

passing_test() -> ?assert(true).

failing_test() -> ?assert(false).

run_app() -> 
    application:start(sasl),
    application:start(ibrowse),
    application:start(couchbeam),
    Server = db_manager:connect(),
    couchbeam:create_db(Server, "sasandzc", [], []),
    http_utilities:print("connected"),
    halt().

