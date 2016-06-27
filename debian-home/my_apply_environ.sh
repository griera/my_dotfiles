#! /bin/bash

while read -r line ; do
    orig_file="$(echo $line | cut -d ' ' -f2)"
    new_file="${PWD}/$(echo $line | cut -d ' ' -f1)"
    rm -rf $orig_file
    ln -s $new_file $orig_file
done < dotfiles_record.txt
