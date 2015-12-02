:- ['../common'].
:- ['../pprint'].

functional :- fail.
min_clauses(1).
max_clauses(5).

limit_recursion :- true.

prim(find_species/2).
prim(find_predation/2).

find_species(A,B):-
  species(Xs),
  member(X,Xs),
  find_sublist(A,B,X).

find_predation(A,B):-
  predation(Xs),
  member(X,Xs),
  find_sublist(A,B,X).

find_sublist(A,B,X):-
  A = In1/[X|Out],
  B = In2/Out,
  append(_,Tail,In1),
  append(X,In2,Tail).

fname(Fname,_,N,K,I,S):-
  ename(Ename),
  atomic_concat([Ename,Fname,N,'-',K,'-',I,'.txt'],S).

pos_train_examples(N,K,Xs):-
  findall(G,
    (
      between(1,N,I),
      fname('/train/pos-input-','.txt',N,K,I,Xname),
      readfile(Xname,X),
      fname('/train/pos-output-','.txt',N,K,I,Yname),
      writeln(Yname),
      readcsv(Yname,Y),
      writeln([y,Y]),
      G =.. [f,X/Y,_/[]]
    ),Xs).

pos_test_examples(N,K,Xs):-
  findall(G,
    (
      between(1,10,I),
      fname('/test/pos-input-','.xml',N,K,I,Xname),
      readfile(Xname,X),
      fname('/test/pos-output-','.xml',N,K,I,Yname),
      readcsv(Yname,Y),
      G =.. [f,X/Y,_/[]]
    ),Xs).

do_experiment(N,K):-
  readcsv('data/species.txt',Species),
  assert(species(Species)),
  readcsv('data/predations.txt',Predations),
  assert(predation(Predations)),
  pos_train_examples(N,K,PosTrain),
  train(PosTrain,[],G,PS),
  pos_test_examples(N,K,PosTest),!,
  test_pos(PosTest,PS,G).

train(Pos,Neg,G,PS):-
  get_time(T1),
  learn(f,Pos,Neg,PS,G),!,
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
f_test_pos(X,_,_,0).

test_deduce(Atom,PS,G):-
  Atoms1 = [Atom],
  prove_deduce(Atoms1,PS,G).