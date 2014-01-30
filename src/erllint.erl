%% @copyright 2014 Takeru Ohta <phjgt308@gmail.com>
%%
%% @doc Erlant Lint Command
-module(erllint).

-export([main/1]).

-spec main([string()]) -> no_return().
main([File]) ->
    ok = io:format(standard_error, "lint target file: ~ts\n", [File]),
    case file:consult(File) of
        {error, Reason = {Line, _, _}} when is_integer(Line) ->
            ok = io:format(standard_error, "=> ERROR: line ~ts\n", [file:format_error(Reason)]),
            halt(1);
        {error, Reason} ->
            ok = io:format(standard_error, "=> ERROR: ~ts\n", [file:format_error(Reason)]),
            halt(1);
        {ok, _} ->
            ok = io:format(standard_error, "=> OK\n", []),
            halt(0)
    end;
main(_Args) ->
    ok = usage(),
    halt(1).

-spec usage() -> ok.
usage() ->
    io:format(standard_error, "Usage: erllint TARGET_ERLANG_FILE\n", []).
