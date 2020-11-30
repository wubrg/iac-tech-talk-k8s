#!/usr/bin/env sh

# Simple entrypoint script that subs the hello world text with a new string based on an env variable

set -e

if [ -z "$HELLO_WORLD_TEXT" ]; then
  HELLO_WORLD_TEXT='Default Hello World'
fi

echo "$HELLO_WORLD_TEXT"

filename='usr/share/nginx/html/index.html'
echo "Replacing variables in index: $filename"
tmp_filename="/tmp/$(basename "$filename")"

# Replace template parameters
sed -e "s/\HELLO_WORLD_TEXT/$(echo "$HELLO_WORLD_TEXT" | sed -e 's/[\/&]/\\&/g')/g" "$filename" > "$tmp_filename"
cat "$tmp_filename" > "$filename"

# Remove temporary file
rm "$tmp_filename"

nginx -g 'daemon off;'
