#!/bin/bash

# Run next lint with the provided command and store the output in a temporary file
tmp_file=$(mktemp)

cd "$1"
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

echo "PATH: $1$file_path"
