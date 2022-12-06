if [ -z "$1" ]
then
      dir_path=node_modules
else
      dir_path=$1
fi
find . -type d -name $dir_path ! -path "*/$dir_path/*" | while IFS= read -r d
do 
    (cd "$d" && touch .nosync && cd -) 
    echo ".nosync file added to $d"
done