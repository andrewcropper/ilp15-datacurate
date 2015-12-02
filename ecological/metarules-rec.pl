metarule(pab_qab,[P,Q],([P,A,B]:-[[Q,A,B]])).
metarule(pab_qac_rcb,[P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).
metarule(pab_qac_pcb,[P,Q],([P,A,B]:-[[Q,A,C],[P,C,B]])).