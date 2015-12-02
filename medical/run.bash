delimitersize=1
filename="results-delimiter-$delimitersize"
rm -rf $filename
mkdir $filename

for k in {1..20}
do
  for m in {1..5}
  do
    swipl --quiet --nodebug << %  >> "$filename/$k-$m.txt"
    ['experiment'].
    do_experiment($m).
%
  done
done