#!/bin/bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/utils.sh


# Run next lint with the provided command and store the output in a temporary file
tmp_file=$(mktemp)


#!/bin/bash

# Start from the current directory
current_dir=`escape_special_chars "$1"`
node_proj_dir=""

# Traverse up the directory tree until we find a package.json or reach the root
while [ "$current_dir" != "/" ] && [ -z "$node_proj_dir"  ]; do
    if [ -f "$current_dir/package.json" ]; then
        node_proj_dir="$current_dir"
    fi
    current_dir=$(dirname "$current_dir")
done

if [ -z "$node_proj_dir" ]; then
  echo "No package.json found in the parent directories."
  exit 1
fi

cd "$node_proj_dir" || exit 1

npx next lint > "$tmp_file" 2>&1
# Process the temporary file to generate the summary output
errors=0
warnings=0

options=()

while read -r line; do
  if [[ $line =~ \.(ts|tsx|js|jsx)$ ]]; then
    if [[ -n "$file" ]]; then
      result="$file:"
      [ "$errors" -gt 0 ] && result+=" [ Total errors: $errors ]"
      [ "$warnings" -gt 0 ] && result+=" [ Total warnings: $warnings ]"
      options+=("$result")
    fi
    file="$line"
    errors=0
    warnings=0
  else
    if [[ $line == *Error* ]]; then
      ((errors++))
    elif [[ $line == *Warning* ]]; then
      ((warnings++))
    fi
  fi
done < "$tmp_file"
if [ -n "$file" ]; then
  result="$file:"
  [ "$errors" -gt 0 ] && result+=" [ Total errors: $errors ]"
  [ "$warnings" -gt 0 ] && result+=" [ Total warnings: $warnings ]"
  options+=("$result")
fi

rm "$tmp_file"

file_path=`printf "%s\n" "${options[@]}" | fzf | grep -oE ".*\.(ts|tsx|js|jsx)"`

echo "PATH: $node_proj_dir/$file_path"
