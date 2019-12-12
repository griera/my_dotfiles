#! /bin/bash

if [ $# -eq 0 ] ; then
    environ=$HOSTNAME
elif [ $# -eq 1 ] ; then
    environ=$1
else
    echo "Usage: $0 [environ_directory]"
    exit 1
fi

environ_path="${PWD}/${environ}"
if ! [ -d $environ_path ] ; then
    echo "$environ environment directory does not exist"
    exit 2
fi

record_file="${environ_path}/dotfiles_record.txt"
while read -r line ; do
    orig_file="$(echo $line | cut -d ' ' -f2)"
    new_file="${environ_path}/$(echo $line | cut -d ' ' -f1)"
    rm -rf $orig_file
    if [ -z "${orig_file##*$HOME*}" ] ; then
        ln -s $new_file $orig_file
    else
        sudo ln -s $new_file $orig_file
    fi
done < $record_file

exit
