#!/bin/bash

# Find and replace '/_next' with '/next' in all files under the current directory

find . -type f -exec grep -Il '/_next' {} \; | while read -r file; do
  echo "Updating: $file"
  sed -i 's|/_next|/next|g' "$file"
done

find . -type f -exec grep -Il '/_buildManifest.js' {} \; | while read -r file; do
  echo "Updating: $file"
  sed -i 's|/_buildManifest.js|/buildManifest.js|g' "$file"
done

find . -type f -exec grep -Il '/_ssgManifest.js' {} \; | while read -r file; do
  echo "Updating: $file"
  sed -i 's|/_ssgManifest.js|/ssgManifest.js|g' "$file"
done

find . -type f -name '_buildManifest.js' | while read -r file; do
  dir=$(dirname "$file")
  newpath="$dir/buildManifest.js"

  if [ -e "$newpath" ]; then
    echo "Skipping rename (already exists): $newpath"
  else
    echo "Renaming: $file -> $newpath"
    mv "$file" "$newpath"
  fi
done

find . -type f -name '_ssgManifest.js' | while read -r file; do
  dir=$(dirname "$file")
  newpath="$dir/ssgManifest.js"

  if [ -e "$newpath" ]; then
    echo "Skipping rename (already exists): $newpath"
  else
    echo "Renaming: $file -> $newpath"
    mv "$file" "$newpath"
  fi
done

echo "Replacement complete."
