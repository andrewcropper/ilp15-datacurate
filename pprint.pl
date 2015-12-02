%% p_rule(pa_qax,[P/1,Q/2,X]):-p_lit(P,['A']),arrow,p_lit(Q,['A',X]).
%% p_rule(pab_qabx,[P/2,Q/3,X]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B',X]).
%% p_rule(pab_qabx1,[P/2,Q/3,X]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B',X]).
%% p_rule(pab_qabx2,[P/2,Q/3,X]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B',X]).
p_rule(pab_qabxy,[P/2,Q/4,X,Y]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B',X,Y]).
p_rule(pab_qabxy1,[P,Q,X,Y]):-p_lit(P,['A','B']),arrow,write(Q),write('(A,B,'),g(X),write(','),g(Y),write(')').
p_rule(pab_qabxy2,[P,Q,X,Y]):-p_lit(P,['A','B']),arrow,write(Q),write('(A,B,'),g(X),write(','),g(Y),write(')').



p_rule(pab_qab,[P,Q]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B']).
p_rule(pab_qabz,[P,Q,Z]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B',Z]).
p_rule(pab_qa_rab,[P,Q,R]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A']),comma,p_lit(R,['A','B']).
p_rule(pab_qab_rb,[P,Q,R]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B']),comma,p_lit(R,['B']).
p_rule(pab_qac_rcb,[P,Q,R]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','C']),comma,p_lit(R,['C','B']).
p_rule(pab_qac_pcb,[P,Q]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','C']),comma,p_lit(P,['C','B']).
p_rule(pab_qacx_rcby,[P,Q,R,X,Y]):-
  p_lit(P,['A','B']),arrow,p_lit(Q,['A','C',X]),comma,p_lit(R,['C','B',Y]).


%% CURRYING

p_rule(pab_qabx,[P,Q,X]):-p_lit(P,['A','B']),arrow,write(Q),write('(A,B,'),g(X),write(')').
p_rule(pab_qabxy,[P,Q,X,Y]):-p_lit(P,['A','B']),arrow,write(Q),write('(A,B,'),g(X),write(','),g(Y),write(')').
%% p_rule(pab_qabargs,[P,Q/_,QArgs]):-p_lit(P,['A','B']),arrow,p_lit(Q,['A','B']), write(QArgs).



%% g([X1]):-
%%   write('['),
%%   write('\''),
%%   write(X1),
%%   write('\''),
%%   write(']').

gg([X]):-!,
  write('\''),
  write(X),
  write('\''),
  write(']').

gg([H|T]):-
  write('\''),
  write(H),
  write('\''),
  write(','),
  gg(T).

g(Xs):-
  write('['),
  gg(Xs).


%% OTHER

%% p_rule(pab_ifelse,[P/2,Cond,Then,Else]):-
%%   p_lit(P,['A','B']),arrow,p_lit(ifelse,[Cond,Then,Else,'A','B']).

%% p_rule(map,[P/2,Q]):-
%%   p_lit(P,['A','B']),arrow,p_lit(map,[Q,'A','B']).

%% p_rule(filter,[P/2,Q]):-
%%   p_lit(P,['A','B']),arrow,p_lit(filter,[Q,'A','B']).

%% p_rule(reduce,[P/2,Q]):-
%%   p_lit(P,['A','B']),arrow,p_lit(reduce,[Q,'A','B']).




p_lit([]):-write(')').
p_lit([H|T]):-write(','),write(H),p_lit(T).
p_lit(P,[H|T]):-write(P),write('('),write(H),p_lit(T).

not_p_lit([]):-write('))').
not_p_lit([H|T]):-write(','),write(H),not_p_lit(T).
not_p_lit(P,[H|T]):-write('not('),write(P),write('('),write(H),not_p_lit(T).

arrow:-write(':- ').
comma:-write(', ').
end:-write('.'),nl.

sub_print_screen(H):-
  H=sub(Name,HOSub),
  p_rule(Name,HOSub),write('.'),nl.

%% sub_print_screen(H):-
%%   H=sub(Name,HOSub),
%%   writeln(Name),false.

print_screen([]).
print_screen([H|T]):-
  sub_print_screen(H),
  print_screen(T).

pprint_([]).
pprint_([H|T]):-
  sub_print_screen(H),
  pprint_(T).

pprint(A):-
  pprint_(A).