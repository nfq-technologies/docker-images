#!/bin/bash
set -e

OUTPUT_FILE="_docs/media/image_relations.gv"

{
    echo "digraph DockerDependencies {"
    echo "  label=\"Image relations\";"
    echo "  graph [fontname=sans pad="0" nodesep="0.1" ranksep="0.2"];"
    echo "  rankdir=\"LR\";"
    echo "  node [style=filled shape=box fontname=sans fillcolor=white];"
} > $OUTPUT_FILE

# Function to extract the FROM line (parent image)
extract_parent_image() {
    grep "^FROM" "$1" | awk '{print $2}'
}

DOCKERFILES="$(find ./ -name Dockerfile)"

# Iterate over all Dockerfiles in the directory
for dockerfile in $DOCKERFILES; do
    if [[ -f "$dockerfile" ]]; then
        image_name="nfqlt/$(basename "$(dirname "$dockerfile")")"
        parent_image=$(extract_parent_image "$dockerfile")

        # If a parent image is found, create a Graphviz edge
        if [[ -n "$parent_image" ]]; then
            echo "\"$image_name\" [fillcolor=orange label=\"$image_name\"];" >>$OUTPUT_FILE
            echo "\"$parent_image\" -> \"$image_name\";" >>$OUTPUT_FILE
        fi
    fi
done

# End the Graphviz DOT file
echo "}" >>$OUTPUT_FILE

# Optional: Generate the dependency graph using Graphviz (install graphviz package first)
dot -Tpng $OUTPUT_FILE -o _docs/media/image_relations.png
