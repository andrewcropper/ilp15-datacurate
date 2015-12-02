:- use_module(library(lists)).

learn(Name,Pos,Neg,G):-
    learn(Name,Pos,Neg,_,G).

learn(Name,Pos,Neg,PS,G):-
    proveall(Name,Pos,PS,G),
    nproveall(Neg,PS,G),
    (functional -> func_test(Pos,PS,G); true).

proveall(Name,Atoms,PS,G):-
    iterator(N,M),
    format('clauses: ~d invented predicates: ~d',[N,M]),nl,
    pred_sig(Name,M,PS),
    prove(Atoms,PS,N,[],G).

prove([],_PS,_MaxN,G,G).

prove([Atom-PostTest|Atoms],PS,MaxN,G1,G2):-!,
    prove_aux(Atom,PS,MaxN,G1,G3),
    call(PostTest),
    prove(Atoms,PS,MaxN,G3,G2).

prove([Atom|Atoms],PS,MaxN,G1,G2):-
    prove_aux(Atom,PS,MaxN,G1,G3),
    prove(Atoms,PS,MaxN,G3,G2).

prove_aux(Atom,_PS,_MaxN,G1,G1):-
    functor(Atom,Name,Arity),
    current_predicate(Name/Arity),!,
    call(Atom).

prove_aux(Atom,PS1,MaxN,G1,G2):-
    lower_preds(PS1,PS2,Atom),
    Atom=..AtomAsList,!,
    metarule(Name,MetaSub,(AtomAsList :- BodyAsList)),
    bind_metasubs(BodyAsList,Body,PS2),
    abduce(G1,G3,sub(Name,MetaSub),MaxN),
    prove(Body,PS1,MaxN,G3,G2).

prove_deduce([],_PS,_G).

prove_deduce([Atom-PostTest|Atoms],PS,G):-!,
    prove_deduce_aux(Atom,PS,G),
    call(PostTest),
    prove_deduce(Atoms,PS,G).

prove_deduce([Atom|Atoms],PS,G):-
    prove_deduce_aux(Atom,PS,G),
    prove_deduce(Atoms,PS,G).

prove_deduce_aux(Atom,_,_):-
    functor(Atom,Name,Arity),
    current_predicate(Name/Arity),!,
    call(Atom).

prove_deduce_aux(Atom,PS,G):-
    member(sub(Name,MetaSub),G),
    Atom=..AtomAsList,
    metarule(Name,MetaSub,(AtomAsList :- BodyAsList)),
    bind_metasubs(BodyAsList,Body,PS),
    prove_deduce(Body,PS,G).


bind_metasubs([],[],_PS).

bind_metasubs([H-PostTest|T],[Atom-PostTest|Atoms],PS):-!,
    bind_to_atom(H,PS,Atom),
    bind_metasubs(T,Atoms,PS).

bind_metasubs([H|T],[Atom|Atoms],PS):-
    bind_to_atom(H,PS,Atom),
    bind_metasubs(T,Atoms,PS).


bind_to_atom([P|Args],PS,Atom):-
    var(P),!,
    length(Args,Arity),
    member(P/Arity,PS),
    Atom=..[P|Args].

bind_to_atom([P|Args],_PS,Atom):-
    Atom=..[P|Args].


nproveall([],_,_).
nproveall([Atom|T],PS,G):-
    not(prove_deduce([Atom],PS,G)),
    nproveall(T,PS,G).

abduce([],[X],X,MaxN):- MaxN > 0,!.

abduce([X|G],[X|G],X,_MaxN):-!.

abduce([E|G],[E|Gnew],X,MaxN):-
    succ(MaxNnext,MaxN),
    abduce(G,Gnew,X,MaxNnext).

inv_preds(_Name,0,[]) :- !.

inv_preds(Name,M,[Sk/_|PS]) :-
    atomic_list_concat([Name,'_',M],Sk),
    succ(Mnext,M),
    inv_preds(Name,Mnext,PS).

pred_sig(Name,M,PS):-
    inv_preds(Name,M,InvPreds),
    findall(P/A, prim(P/A), Prims),
    append(InvPreds,Prims,PS).

lower_preds(PS1,PS2,Atom):-
    functor(Atom,P,Arity),
    append(_,[P/Arity|PS2],PS1),!.

lower_preds(PS,PS,_).

iterator(N,M):-
    min_clauses(MIN),
    max_clauses(MAX),!,
    between(MIN,MAX,N),
    succ(MaxM,N),
    between(0,MaxM,M).

func_test([],_,_).

func_test([Atom|Atoms],PS,G) :-
    do_func_test(Atom,PS,G),
    func_test(Atoms,PS,G).