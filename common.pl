:- [metagol].

a(X):-
  get_char(T),
  ((T=end_of_file) -> (X=[]) ; (X=[T|Out],a(Out))).

readfile(Name,X):-
  see(Name),
  a(X),!.

readcsv(Fname,Out):-
  readfile(Fname,F),
  read_csv_(F,[],Xs),!,
  findall(Y, ((member(X,Xs),reverse(X,Y))), Out).

read_csv_([],Buf,[Buf|[]]).
read_csv_(['$'|T],Buf,[Buf|Out]) :- !,
  read_csv_(T,[],Out).
read_csv_([H|T],Buf,Out):-
  read_csv_(T,[H|Buf],Out).

open_interval(Input1/[X|Output1],Tail/Output1,[S1],[E1]):-
  append(Head,Tail,Input1),
  append(_,[S1|X],Head),
  append([E1],_,Tail),!.

open_interval(Input1/[X|Output1],Tail/Output1,[S1,S2],[E1,E2]):-
  append(Head,Tail,Input1),
  append(_,[S1,S2|X],Head),
  append([E1,E2],_,Tail),!.

open_interval(Input1/[X|Output1],Tail/Output1,[S1,S2,S3],[E1,E2,E3]):-
  append(Head,Tail,Input1),
  append(_,[S1,S2,S3|X],Head),
  append([E1,E2,E3],_,Tail),!.

open_interval(Input1/[X|Output1],Tail/Output1,[S1,S2,S3,S4],[E1,E2,E3,E4]):-
  append(Head,Tail,Input1),
  append(_,[S1,S2,S3,S4|X],Head),
  append([E1,E2,E3,E4],_,Tail),!.

%% closed_open_interval(Input1/[X|Output1],Tail/Output1,[S1],[E1]):-
%%   append(Head,Tail,Input1),
%%   append(_,[S1|X],Head),
%%   append([E1],_,Tail),!.

skip_to1([E1|T]/Out,T/Out,[E1]):- !.
skip_to1([_|T]/Out,Input2/Out,[E1]):- !,skip_to1(T/Out,Input2/Out,[E1]).

skip_to2([E1,E2|T]/Out,T/Out,[E1,E2]):- !.
skip_to2([_|T]/Out,Input2/Out,[E1,E2]):-!,skip_to2(T/Out,Input2/Out,[E1,E2]).

skip_to3([E1,E2,E3|T]/Out,T/Out,[E1,E2,E3]):- !.
skip_to3([_|T]/Out,Input2/Out,[E1,E2,E3]):-!,skip_to3(T/Out,Input2/Out,[E1,E2,E3]).

skip_to4([E1,E2,E3,E4|T]/Out,T/Out,[E1,E2,E3,E4]):- !.
skip_to4([_|T]/Out,Input2/Out,[E1,E2,E3,E4]):-!,skip_to4(T/Out,Input2/Out,[E1,E2,E3,E4]).


do_func_test([P,A,B]-true,PS,G) :-
  A = In/Expected,
  B = _/[],
  prove_deduce([[P,In/Actual,B]-true],PS,G),
  Expected \= Actual,
  !,false.

do_func_test(_,_,_).