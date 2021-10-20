#!/bin/bash

TMPFILE=/tmp/release.$1.data

curl   -H "Accept: application/vnd.github.v3+json"   https://api.github.com/repos/cloud-hypervisor/cloud-hypervisor/releases/tags/$1 > /tmp/release.$1.data

NAME=`jq -r <$TMPFILE .name`
BODY=`jq -r <$TMPFILE .body`
DATE=`jq -r <$TMPFILE .published_at`
URL=`jq -r <$TMPFILE .html_url`
mkdir content/en/blog/$NAME
echo -e "---\ntitle: \"Cloud Hypervisor $NAME Released!\"\ndate: $DATE\ndraft: false\ncontributors: ["Cloud Hypervisor Team"]\n---\n$BODY\n### Download\n See the <a href=\"$URL\">GitHub Release</a> for the release assets." > content/en/blog/$NAME/index.md
