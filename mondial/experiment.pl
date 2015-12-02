:- ['../common'].
:- ['../pprint'].

:- use_module(library(timeout)).

functional :- false.
limit_recursion :- true.

min_clauses(1).
max_clauses(5).

prim(skip_to4/3).
prim(skip_to3/3).
prim(open_interval/4).

fname(Fname,_,N,K,I,S):-
  ename(Ename),
  Xs = [Ename,Fname,N,'-',K,'-',I,'.txt'],
  atomic_list_concat(Xs,S).

pos_train_examples(N,K,Xs):-
  findall(G,
    (
      between(1,N,I),
      fname('/train/pos-input-','.xml',N,K,I,Xname),
      %% writeln([xname,Xname]),
      readfile(Xname,X),
      fname('/train/pos-output-','.xml',N,K,I,Yname),
      readcsv(Yname,Y),
      %% writeln([pos_train,Y]),
      G =..[f,X/Y,_/[]]
    ),Xs).


neg_train_examples(N,K,Xs):-
  findall(G,
    (
      between(1,N,I),
      fname('/train/neg-input-','.xml',N,K,I,Xname),
      readfile(Xname,X),
      fname('/train/neg-output-','.xml',N,K,I,Yname),
      readcsv(Yname,Y),
      G =..[f,X/Y,_/[]]
      %% writeln([neg_train,Y])
    ),Xs).


pos_test_examples(N,K,Xs):-
  findall(G,
    (
      between(1,10,I),
      fname('/test/pos-input-','.xml',N,K,I,Xname),
      readfile(Xname,X),
      fname('/test/pos-output-','.xml',N,K,I,Yname),
      readcsv(Yname,Y),
      G =..[f,X/Y,_/[]]
    ),Xs).


neg_test_examples(N,K,Xs):-
  findall(G,
    (
      between(1,10,I),
      fname('/test/neg-input-','.xml',N,K,I,Xname),
      readfile(Xname,X),
      fname('/test/neg-output-','.xml',N,K,I,Yname),
      readcsv(Yname,Y),
      G =..[f,X/Y,_/[]]
    ),Xs).


do_experiment(N,K):-
  pos_train_examples(N,K,PosTrain),!,
  neg_train_examples(N,K,NegTrain),!,
  %% writeln(PosTrain),
  %% writeln(NegTrain),
  train(PosTrain,NegTrain,G,PS),!,
  pos_test_examples(N,K,PosTest),!,
  neg_test_examples(N,K,NegTest),!,
  test_pos(PosTest,PS,G),!,
  test_neg(NegTest,PS,G).

train(Pos,Neg,G,PS):-
  get_time(T1),
  time_out(learn(f,Pos,Neg,PS,G), 600000, Res),
  ((Res = timeout) -> (!, writeln('TIMEOUT'),false); true),
  %% writeln(G),
  get_time(T2),!,
  pprint(G),
  Delta is T2-T1,
  write('time,'),write(Delta), nl.

train(_,_,[],[]).


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

test_deduce(Atom,PS,G):-
  Atoms1 = [Atom],
  prove_deduce(Atoms1,PS,G).