ename="results-2"

instances=24
trials=20
maxexamples=5

rm -rf $ename
mkdir $ename

mkdir $ename/test
mkdir $ename/train
mkdir $ename/results-rec
mkdir $ename/results-no-rec

for k in `seq $trials`
do
  for n in `seq $maxexamples`
  do
    # pos training
    for i in `seq $n`
    do
      j=`jot -r 1 1 $instances`
      cp data/input-$j.txt $ename/train/pos-input-$n-$k-$i.txt
      cp data/output-$j.txt $ename/train/pos-output-$n-$k-$i.txt
    done
    # pos testing
    for i in {1..10}
    do
      j=`jot -r 1 1 $instances`
      cp data/input-$j.txt $ename/test/pos-input-$n-$k-$i.txt
      cp data/output-$j.txt $ename/test/pos-output-$n-$k-$i.txt
    done
  done
done

for n in `seq $maxexamples`
do
  for k in `seq $trials`
  do
    echo $n $k
    yap << % >> "$ename/results-rec/$n-$k.txt"
    assert(ename($ename)).
    ['experiment'].
    ['metarules-rec'].
    do_experiment($n,$k).
%
  done
done

for n in `seq $maxexamples`
do
  for k in `seq $trials`
  do
    echo $n $k
    yap << % >> "$ename/results-no-rec/$n-$k.txt"
    assert(ename($ename)).
    ['experiment'].
    ['metarules-no-rec'].
    do_experiment($n,$k).
%
  done
done

python results.py $ename/results-rec $maxexamples $trials
python results.py $ename/results-no-rec $maxexamples $trials