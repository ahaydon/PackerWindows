#!/bin/bash

file=$1
key=$2

[ ! -d ./tmp/ ] && mkdir ./tmp

if [ "_${key}_" = "__" ]
then
    echo "No key provided"
    cp $file ./tmp/Autounattend.xml
else
    sed -e "s/<!-- <Key>xxxxx-xxxxx-xxxxx-xxxxx-xxxxx<\/Key> -->/<Key>${key}<\/Key>/g" $1 > ./tmp/Autounattend.xml
fi
