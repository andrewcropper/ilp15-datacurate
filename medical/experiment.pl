:- [examples1].
:- ['../common'].
:- ['../pprint'].

test_size(10).
functional :- fail.
min_clauses(1).
max_clauses(6).

prim(find_patient_id/2).
prim(find_age/2).
prim(find_feev/2).
prim(open_interval/4).
%% prim(closed_interval/4).
%% prim(find_sublist/3).

find_patient_id(A,B):-
  patient_id(String),
  str_to_list(String,X),
  find_sublist(A,B,X).

find_age(A,B):-
  age(String),
  str_to_list(String,X),
  find_sublist(A,B,X).

find_feev(A,B):-
  feev(String),
  str_to_list(String,X),
  find_sublist(A,B,X).

metarule(pab_qab,[P,Q],([P,A,B]:-[[Q,A,B]])).
metarule(pab_qabx,[P,Q,X],([P,A,B]:-[[Q,A,B,X]])).
metarule(pab_qabxy,[P,Q,X,Y],([P,A,B]:-[[Q,A,B,X,Y]])).
metarule(pab_qabxy1,[P,Q,X,Y],([P,A,B]:-[[Q,A,B,X,Y]])).
metarule(pab_qabxy2,[P,Q,X,Y],([P,A,B]:-[[Q,A,B,X,Y]])).
metarule(pab_qac_rcb,[P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).

%% metarule(pab_qabxy,[P,Q,X,Y],([P,A,B]:-[[Q,A,B,X,Y]])).
%% metarule(pab_qac_rcb,[P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).
%% metarule(pab_qac_pcb,[P,Q],([P,A,B]:-[[Q,A,C]-QPostTest,[P,C,B]-PPostTest])):-
%%   QPostTest = obj_gt(A,C),
%%   PPostTest = obj_gt(C,B).

tmp([],[]).

tmp([H|T],[Out|Z]):-
  str_to_list(H,Str),
  append(Str, [' '],Out),
  tmp(T,Z).

neg_example(Terms,Lengths,Input,Output) :-
  random_permutation(Terms,RandPermTerms),
  random_permutation(Lengths,RandPermLengths),!,
  RandPermLengths = [NegInputLength|_],
  length(NegInput1,NegInputLength),
  append(NegInput1,_,RandPermTerms),
  tmp(NegInput1,NegInput2),
  flatten(NegInput2,Input),
  random_permutation(NegInput1,RandPermNegInput),
  length(NegOutput1,3),
  append(NegOutput1,_,RandPermNegInput),
  maplist(str_to_list,NegOutput1,Output).

neg_examples(G,PS,10,Xs) :-
  findall(XTerm,
  (
    e(X,_),
    split_string(X, "£", "",XTerms),
    member(XTerm,XTerms)
  ),Terms),

  findall(Length,
  (
    e(X,_),
    split_string(X, "£", "",XTerms),
    length(XTerms,Length)
  ),Lengths),
  !,
  findall(G,(
    between(1,10,_),
    neg_example(Terms,Lengths,In,Out),
    G =.. [f,In/Out,_/[]],
    not(test_deduce([G],PS,G))
  ),Xs).


pos_examples(Xs):-
  findall(G,(
    e(In1,Out1),
    str_to_list(In1,In2),
    maplist(str_to_list,Out1,Out2),
    G =.. [f,In2/Out2,_/[]]
  ),Xs).

str_to_list(String,Characters) :-
  name(String,Xs),
  maplist(number_to_character,Xs,Characters).

number_to_character(Number,Character) :-
  name(Character,[Number]).

do_experiment(M):-
  pos_examples(Xs),
  random_permutation(Xs,Examples),
  length(Train,M),
  length(TestPos,10),
  append(Train,Remainder,Examples),
  append(TestPos,_,Remainder),!,
  do_train(Train,G,PS),!,
  neg_examples(G,PS,10,TestNeg),!,
  test_pos(TestPos,G,PS),
  test_neg(TestNeg,G,PS).

do_train(Train,PS,G):-
  get_time(T1),
  learn(f,Train,[],PS,G),!,
  get_time(T2),!,
  pprint(G),
  Delta is T2-T1,
  write('time,'),write(Delta), nl.
do_train(_,[],[]).


test_pos([],_,_).
test_pos([H|T],PS,G):-
  f_test_pos(H,PS,G,Score),
  write('score,'),write(Score),nl,
  test_pos(T,PS,G).

f_test_pos(X,PS,G,1):-
  test_deduce(X,PS,G),!.
f_test_pos(_,_,_,0).

test_neg([],_,_).
test_neg([H|T],PS,G):-
  f_test_neg(H,PS,G,Score),
  write('score,'),write(Score),nl,
  test_neg(T,PS,G).

f_test_neg(X,PS,G,0):-
  test_deduce(X,PS,G),!.
f_test_neg(_,_,_,1).

find_sublist(A,B,X):-
  A = In1/[X|Out],
  B = In2/Out,
  append(_,Tail,In1),
  append(X,In2,Tail).

test_deduce(Atom,PS,G):-
  Atoms1 = [Atom],
  prove_deduce(Atoms1,PS,G).