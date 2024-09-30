#!/bin/bash -e

work_dir=$(dirname "$(dirname "$(realpath "$0")")")
media_dir='./_docs/media'
result_file_name='image_relations'
gv_file="$media_dir/$result_file_name.gv"
png_file="$media_dir/$result_file_name.png"

cd "$work_dir"

{
  echo "digraph $result_file_name {"
  echo '  graph [fontname=sans pad="0" nodesep="0.2" ranksep="0.3"];'
  echo '  rankdir="LR";'
  echo '  node [style=filled shape=box fontname=sans fillcolor=white];'
} > $gv_file

for docker_file in ./*/Dockerfile; do
  parent_image="$(grep '^FROM ' "$docker_file" | awk '{print $2}' | sed 's/^nfqlt\///')"
  image=$(basename "$(dirname "$docker_file")")
  echo "  \"$parent_image\" -> \"$image\";" >> $gv_file
  echo "  \"$image\" [fillcolor=orange];" >> $gv_file
done

echo '}' >> $gv_file
dot -Tpng $gv_file -o $png_file
