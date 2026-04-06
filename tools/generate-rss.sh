#!/bin/bash

now=$(date "+%a, %d %b %Y %H:%M:%S %z")
file=rss.xml


cat > $file << EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title>Pancatime</title>
        <link>https://pancatime.com/</link>
        <description>Latest posts from panca</description>
        <language>en-US</language>
        <lastBuildDate>${now}</lastBuildDate>
        <atom:link href="https://pancatime.com/index.html" rel="self" type="application/rss+xml"/>

        <item>
            <title></title>
            <link>https://pancatime.com/posts/devblog-26-03-15.html</link>
            <pubDate></pubDate>
            <guid>https://pancatime.com/posts/devblog-26-03-15.html</guid>
            <description>In Luke's case this is just the entire article xD</description>
        </item>

    </channel>
</rss>
EOF
cat rss.xml
