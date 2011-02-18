-module(billing_app).
-author("Serge Ziryukin <ftrvxmtrx@gmail.com>").

-behaviour(application).
-export([start/2,stop/1]).

-define(NUM_RECORDS, 1000).

%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for billing.
start(_Type, _StartArgs) ->
    billing_deps:ensure(),
    billing_db:start_link(),
    %billing_db_events:start_link(),
    billing_db:add_test_records(?NUM_RECORDS),
    billing_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for billing.
stop(_State) ->
    ok.