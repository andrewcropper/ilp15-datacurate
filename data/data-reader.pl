%% a(X):-
%%   get_char(T),
%%   ((T=end_of_file) -> (X=[]) ; (X=[T|Out],a(Out))).

%% readfile(Name,X):-
%%   see(Name),
%%   a(X),!.

%% x:- readfile('mondial/1.xml',X), writeln(X).

x :-
  csv_read_file('test.csv',Xs),
  %% member(row(X),Xs),
  findall(X,member(row(X),Xs),Ys),
  writeln(Ys).