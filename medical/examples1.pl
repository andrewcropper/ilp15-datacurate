e("P_001$N£67£year$N£66£inch$N£lung£disease:£not£specified,£Diagnosis:£Unknown$N£80.78$N£1.63",["P_001","67","Unknown","1.63"]).

e("P_002$N£77$N£67£inch$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£pneumonia$N£53$N£1.29",["P_002","77","pneumonia","1.29"]).

e("P_003$N£64£years$N£65£inch$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£Acute£bronchitis$N£54$N£2.06%",["P_003","64","Acute£bronchitis","2.06"]).

e("P_004$N£59£year$N£58$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£non-small£cell£squamous£cell£carcinoma$N£44$N£0.55",["P_004","59","non-small£cell£squamous£cell£carcinoma","0.55"]).

e("P_005$N£61$N£66$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£Tuberculosis$N£59$N£1.7%",["P_005","61","Tuberculosis","1.7"]).

e("P_006$N£63£year$N£72£inch$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£Chronic£obstructive£pulmonary£disease$N£58$N£2.54",["P_006","63","Chronic£obstructive£pulmonary£disease","2.54"]).

e("P_007$N£56£year$N£72$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£Emphysema$N£56$N£1.87£%",["P_007","56","Emphysema","1.87"]).

e("P_008$N£70$N£71$N£lung£disease:£chronic£obstructive£pulmonary£disease,£Diagnosis:£Leukemia$N£55.9$N£0.9",["P_008","70","Leukemia","0.9"]).

e("P_009$N£77$N£67£inch$N£Diagnosis:£Sarcoma,£lung£disease:£chronic£obstructive£pulmonary£disease$N£53$N£1.29",["P_009","77","Sarcoma","1.29"]).

e("P_010$N£70$N£71$N£Diagnosis:£Sarcoma£botryoides,£lung£disease:£chronic£obstructive£pulmonary£disease$N£55.9$N£0.9",["P_010","70","Sarcoma£botryoides","0.9"]).

e("P_011$N£70$N£71$N£Diagnosis:£Osteosarcoma,£lung£disease:£unknown$N£55.9$N£0.9",["P_011","70","Osteosarcoma","0.9"]).

e("P_012$N£70$N£71$N£Diagnosis:£Lymphoma,£lung£disease:£chronic£obstructive£pulmonary£disease$N£55.9$N£0.9",["P_012","70","Lymphoma","0.9"]).

e("P_013$N£70$N£71$N£Diagnosis:£Blastoma,£lung£disease:£chronic£obstructive£pulmonary£disease$N£55.9$N£0.9",["P_013","70","Blastoma","0.9"]).

e("P_014$N£70$N£71$N£Diagnosis:£bronchiectasis,£lung£disease:£not£specified$N£55.9$N£0.9",["P_014","70","bronchiectasis","0.9"]).

e("P_015$N£61$N£66$N£Diagnosis:£not£specified,£lung£disease:£chronic£obstructive£pulmonary£disease$N£59$N£1.7%",["P_015","61","not£specified","1.7"]).

e("P_016$N£70$N£71$N£Diagnosis:£idiopathic£bronchiectasis,£lung£disease:£not£specified$N£55.9$N£0.9",["P_016","70","idiopathic£bronchiectasis","0.9"]).

patient_id("P_001").
patient_id("P_002").
patient_id("P_003").
patient_id("P_004").
patient_id("P_005").
patient_id("P_006").
patient_id("P_007").
patient_id("P_008").
patient_id("P_009").
patient_id("P_010").
patient_id("P_011").
patient_id("P_012").
patient_id("P_013").
patient_id("P_014").
patient_id("P_015").
patient_id("P_016").


%% debug :-
%%     e(_,[X,_,_,_]),
%%     not(patient_id(X)),
%%     writeln(X).

%% debug :-
%%     e(_,[_,X,_,_]),
%%     not(age(X)),
%%     write('age('),write(X), write(').'),nl.

%% debug :-
%%     e(_,[_,_,_,X]),
%%     not(feev(X)),
%%     write('feev("'),write(X), write('").'),nl.

age("70").
age("67").
age("64").
age("59").
age("61").
age("63").
age("56").
age("77").

feev("0.9").
feev("1.63").
feev("1.29").
feev("2.06").
feev("0.55").
feev("1.7").
feev("2.54").
feev("1.87").
feev("1.29").
