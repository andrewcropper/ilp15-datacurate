ename="results-2"

rm -rf $ename
mkdir $ename

mkdir $ename/test
mkdir $ename/train
mkdir $ename/results-rec
mkdir $ename/results-no-rec

trials=20
examples=10
instances=231

for k in `seq $trials`
do
  for n in `seq $examples`
  do
    # pos training
    for i in `seq $n`
    do
      j=`jot -r 1 10 132`
      cp data/simple-parsed/input-$j.txt $ename/train/pos-input-$n-$k-$i.txt
      cp data/simple-parsed/output-$j.txt $ename/train/pos-output-$n-$k-$i.txt
    done
    # neg train input
    for i in `seq $n`
    do
      j=`jot -r 1 10 132`
      cp data/simple-parsed/input-$j.txt $ename/train/neg-input-$n-$k-$i.txt
      python gen-neg.py data/simple-parsed/input-$j.txt > $ename/train/neg-output-$n-$k-$i.txt
    done

    # pos testing
    for i in {1..10}
    do
      j=`jot -r 1 1 $instances`
      cp data/parsed/input-$j.txt $ename/test/pos-input-$n-$k-$i.txt
      cp data/parsed/output-$j.txt $ename/test/pos-output-$n-$k-$i.txt
    done

    # neg test output
    for i in {1..10}
    do
      j=`jot -r 1 1 $instances`
      cp data/parsed/input-$j.txt $ename/test/neg-input-$n-$k-$i.txt
      python gen-neg.py data/parsed/input-$j.txt > $ename/test/neg-output-$n-$k-$i.txt
    done
  done
done

# python setup.py $ename $trials $examples


for k in `seq $trials`
do
  for n in `seq $examples`
  do
    echo $n $k
    yap << % >> "$ename/results-no-rec/$n-$k.txt"
    assert(ename('$ename')).
    ['experiment'].
    ['metarules-no-rec'].
    do_experiment($n,$k).
%
  done
done


for k in `seq $trials`
do
  for n in `seq $examples`
  do
    echo $n $k
    yap << % >> "$ename/results-rec/$n-$k.txt"
    assert(ename('$ename')).
    ['experiment'].
    ['metarules-rec'].
    do_experiment($n,$k).
%
  done
done

python results.py $ename/results-rec $examples $trials
python results.py $ename/results-no-rec $examples $trials