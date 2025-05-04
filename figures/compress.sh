#!/bin/bash

TARGET_SIZE=102400  # 100 KB in bytes

mkdir -p compressed

for file in *.png; do
  quality=80  # starting quality range value
  output="compressed/$file"
  cp "$file" "$output"
  
  # Check file size and reduce quality/dimensions iteratively if over TARGET_SIZE
  while [ $(stat -c%s "$output") -gt $TARGET_SIZE ] && [ $quality -ge 10 ]; do
    echo "Compressing $file with quality=$quality..."
    # Use pngquant to attempt to lower the file size
    pngquant --quality=$quality-$quality --output "$output" --force "$file"
    
    # If file size is still large, optionally further reduce the dimensions by 10%
    if [ $(stat -c%s "$output") -gt $TARGET_SIZE ]; then
      convert "$output" -resize 90% -strip "$output"
    fi
    
    quality=$((quality - 10))
  done
  
  echo "$file compressed to $(stat -c%s "$output") bytes"
done