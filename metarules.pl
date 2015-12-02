metarule(pab_qab,[P/2,Q/2],([P,A,B]:-[[Q,A,B]])).

metarule(pab_qba,[P/2,Q/2],([P,A,B]:-[[Q,B,A]])).

metarule(pab_qa_rab,[P/2,Q/1,R/2],([P,A,B]:-[[Q,A],[R,A,B]])).

metarule(pab_qab_rb,[P/2,Q/2,R/1],([P,A,B]:-[[Q,A,B],[R,B]])).