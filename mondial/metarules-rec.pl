metarule(pab_qabxy1,[P,Q,X,Y],([P,A,B]:-[[Q,A,B,X,Y]])).
metarule(pab_qac_rcb,[P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).
metarule(pab_qac_pcb,[P,Q],([P,A,B]:-[[Q,A,C]-QPostTest,[P,C,B]-PPostTest])):-
  QPostTest = obj_gt(A,C),
  PPostTest = obj_gt(C,B).

obj_gt(X,Y):-
  duplicate_term(X,A),
  duplicate_term(Y,B),
  A = In1/_,
  B = In2/_,
  length(In1,N1),
  length(In2,N2),
  N1 > N2.