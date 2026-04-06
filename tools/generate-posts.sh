#!/bin/bash

# This script combines html template and markdown, then outputs html file for each document

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
in_dir=${script_dir}/../posts/raw/
out_dir=${script_dir}/../posts/

template1=${in_dir}template1.html
template2=${in_dir}template2.html

for md_file in ${in_dir}*.md
do
    echo "Processing: ${md_file}."
    file_name="${md_file#$in_dir}"
    new_file=${out_dir}${file_name%.md}.html
    cat $template1 $md_file $template2 > $new_file
    echo "Out: ${new_file}"
done

echo "Done."
