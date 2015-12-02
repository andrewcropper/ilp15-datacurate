rm -rf parsed
mkdir parsed

tr '\n' '$' < mondial.xml > mondial-clean.xml
sed -i .bak 's/\$//g' mondial-clean.xml
sed -i .bak 's/< /</g' mondial-clean.xml
sed -i .bak 's/ </</g' mondial-clean.xml
sed -i .bak 's/> />/g' mondial-clean.xml
sed -i .bak 's/ >/>/g' mondial-clean.xml

python parse.py

for i in {1..231}
do
  sed -i .bak 's/  //g' parsed/input-$i.txt
done

rm parsed/*.bak
rm mondial-clean*