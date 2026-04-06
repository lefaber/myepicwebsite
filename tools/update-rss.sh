#!/bin/bash

# Fetches metadata from markdown files and generates rss xml

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
project_dir=${script_dir}/..
out_file=${project_dir}/rss.xml
in_dir=${project_dir}/posts/raw/
domain="pancatime.com"

now=$(date "+%a, %d %b %Y %H:%M:%S %z")

# Build items variable
items=""
for md_file in ${in_dir}*.md
do
	# read csv line
	echo "Processing: ${md_file}."

	# Split csv and store in array
	csv_str=$(sed '3q;d' ${md_file})
	IFS=";" read -ra csv_array <<< "$csv_str"

	file_name="${md_file#$in_dir}"
	blog_link="https://${domain}/posts/${file_name%.md}.html"
	blog_pubdate="${csv_array[0]}"
	blog_title="${csv_array[1]}"
	blog_desc="${csv_array[2]}"

	# Concat xml to items variable
	IFS='' read -r -d '' items <<EOF
${items}
		<item>
			<title>${blog_title}</title>
			<link>${blog_link}</link>
			<pubDate>${blog_pubdate}</pubDate>
			<guid>${blog_link}</guid>
			<description>${blog_desc}</description>
		</item>
EOF

done

# Output complete xml to file
cat > $out_file << EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>${domain}</title>
		<link>https://${domain}/</link>
		<description>Latest posts from panca</description>
		<language>en-US</language>
		<lastBuildDate>${now}</lastBuildDate>
		<atom:link href="https://${domain}/index.html" rel="self" type="application/rss+xml"/>
		${items}
	</channel>
</rss>
EOF
cat $out_file
