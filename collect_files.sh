#!/bin/bash
if [ "$1" = "--max_depth" ]; then
  maxd=$2
  shift 2
else
  maxd=""
fi

if [ $# -lt 2 ]; then
  echo "Использование: $0 [--max_depth N] input_dir output_dir"
  exit 1
fi

indir=$1
outdir=$2
mkdir -p "$outdir"

if [ -n "$maxd" ]; then
  depth_opt="-maxdepth $maxd"
else
  depth_opt=""
fi

find "$indir" $depth_opt -type f | while read file; do
  base=$(basename "$file")
  if [ -e "$outdir/$base" ]; then
    n=1
    newname="${n}_$base"
    while [ -e "$outdir/$newname" ]; do
      n=$((n+1))
      newname="${n}_$base"
    done
    cp "$file" "$outdir/$newname"
  else
    cp "$file" "$outdir/$base"
  fi
done
