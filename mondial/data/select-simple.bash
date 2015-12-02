rm -rf simple-parsed
cp -R parsed simple-parsed

filename="simple.txt"
i=1
while read -r line
do
    x=$line
    cp parsed/input-$x.txt simple-parsed/input-$i.txt
    cp parsed/output-$x.txt simple-parsed/output-$i.txt
    echo "$name $i"
    ((i++))
done < "$filename"
