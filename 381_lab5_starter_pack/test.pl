% Define the family tree data (as previously loaded)
:- consult('lab5.pl').

% Define all predicates
predicates([
    mother/2, father/2, spouse/2, child/2, son/2, daughter/2,
    sibling/2, brother/2, sister/2, uncle/2, aunt/2, grandparent/2,
    grandfather/2, grandmother/2, grandchild/2, ancestor/2, descendant/2,
    older/2, younger/2, regentWhenBorn/2, cousin/2
]).
:- consult('royal.pl').
% Generate all possible tests for a predicate
generate_tests(Predicate/2, Tests) :-
    findall([X, Y], (call(Predicate, X, Y), atomic(X), atomic(Y)), Tests).

% Test a predicate with all generated tests
test_predicate(Predicate/2) :-
    generate_tests(Predicate, Tests),
    test_predicate(Tests).

test_predicate([]).
test_predicate([[X, Y] | Rest]) :-
    (   once(call(Predicate, X, Y)) -> Status = 'Pass'
    ;   Status = 'Fail'
    ),
    format("~w(~w, ~w) - ~w~n", [Predicate, X, Y, Status]),
    test_predicate(Rest).

% Run all tests for all predicates
run_tests :-
    predicates(Predicates),
    run_tests(Predicates).

run_tests([]).
run_tests([Predicate | Rest]) :-
    test_predicate(Predicate),
    run_tests(Rest).

% Start the test runner
:- run_tests.
