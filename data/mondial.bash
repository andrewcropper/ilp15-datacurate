# tidy input
rm -rf pos
rm -rf neg

mkdir pos
mkdir neg

tr '\n' '$' < mondial.xml > mondial-clean.xml
sed -i .bak 's/\$//g' mondial-clean.xml
sed -i .bak 's/< /</g' mondial-clean.xml
sed -i .bak 's/ </</g' mondial-clean.xml
sed -i .bak 's/> />/g' mondial-clean.xml
sed -i .bak 's/ >/>/g' mondial-clean.xml

python data-parser.py

for i in {1..231}
do
  sed -i .bak 's/  //g' mondial/input-$i.xml
done

rm mondial-clean*