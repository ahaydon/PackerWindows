file=$1
key=$2
sed -e "s/<!-- <Key>xxxxx-xxxxx-xxxxx-xxxxx-xxxxx<\/Key> -->/<Key>${key}<\/Key>/g" $1 > ./tmp/Autounattend.xml
