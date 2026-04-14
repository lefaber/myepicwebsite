#!/bin/bash

# This script combines html template and markdown, then outputs html file for each document

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
in_dir=${script_dir}/../posts/raw/
out_dir=${script_dir}/../posts/

#template1=${in_dir}template1.html
#template2=${in_dir}template2.html

for md_file in ${in_dir}*.md
do
	echo "Processing: ${md_file}."
	file_name="${md_file#$in_dir}"
	new_file=${out_dir}${file_name%.md}.html

	# split csv and store in array
	csv_str=$(sed '3q;d' ${md_file})
	ifs=";" read -ra csv_array <<< "$csv_str"

	#blog_link="https://${domain}/posts/${file_name%.md}.html"
	#blog_pubdate="${csv_array[0]}"
	blog_title="${csv_array[1]}"
	#blog_desc="${csv_array[2]}"

	cat > $new_file << EOF
<!DOCTYPE html>
<html lang="en">
<head>
	<title>${blog_title} | Pancatime</title> 
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- styles -->
	<link rel="stylesheet" href="../normalize.css">
	<link rel="stylesheet" href="../globals.css">
    <!-- favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="../apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../favicon-16x16.png">
    <link rel="manifest" href="../site.webmanifest">
    <!-- js -->
	<script src="../color.js"></script>
</head>
<body class="retro text-shadow">

<div class="wrapper">
	<header class="main-header" style="margin-top: 128px;">
		<nav><a class="menu-item" href="../blog.html">back</a></nav>
	</header>
	<main>
		<article class="blog-post">

		${template2}

        </article>
	</main>
</div>

</body>
</html>
EOF
	echo "Out: ${new_file}."
done

echo "Done."
