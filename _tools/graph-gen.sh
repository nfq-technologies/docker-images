#!/bin/bash -e
#
# Docker Images Dependency Graph Generator
#
# Generates a visual dependency graph of all Docker images.
# Color coded by status: Active (green), Maintenance (yellow), EOL (red)
# Grouped by image family (PHP, Database, Node, etc.)
#
# Compatible with bash 3.2+ (macOS default)
#

work_dir=$(dirname "$(dirname "$(realpath "$0")")")
media_dir='./_docs/media'
result_file_name='image_relations'
gv_file="$media_dir/$result_file_name.gv"
png_file="$media_dir/$result_file_name.png"
svg_file="$media_dir/$result_file_name.svg"

cd "$work_dir"

# Temp files for collecting data
tmp_dir=$(mktemp -d)
trap "rm -rf $tmp_dir" EXIT

# === Status Detection ===

# EOL images (no longer maintained, should not be used for new projects)
# Auto-detect from _deprecated/ directory
if [ -d "_deprecated" ]; then
	EOL_PATTERNS=$(ls -d _deprecated/*/ 2>/dev/null | xargs -n1 basename | tr '\n' ' ' || echo "")
else
	EOL_PATTERNS=""
fi

# Maintenance images (security fixes only, migrate when possible)
MAINTENANCE_PATTERNS="php74 php80 bullseye"

is_eol() {
	local img="$1"
	for pattern in $EOL_PATTERNS; do
		if [[ "$img" == *"$pattern"* ]]; then
			return 0
		fi
	done
	return 1
}

is_maintenance() {
	local img="$1"
	# Don't mark as maintenance if already EOL
	is_eol "$img" && return 1
	for pattern in $MAINTENANCE_PATTERNS; do
		if [[ "$img" == *"$pattern"* ]]; then
			return 0
		fi
	done
	return 1
}

get_color() {
	local img="$1"
	if is_eol "$img"; then
		echo "#ffcccc"  # Red - EOL
	elif is_maintenance "$img"; then
		echo "#ffffcc"  # Yellow - Maintenance
	else
		echo "#ccffcc"  # Green - Active
	fi
}

# === Clustering ===

get_cluster() {
	local img="$1"
	case "$img" in
		php*) echo "php" ;;
		mysql*|mariadb*|postgres*) echo "database" ;;
		elasticsearch*) echo "elasticsearch" ;;
		node*|cypress*) echo "nodejs" ;;
		nginx*|apache*|https-dev) echo "webserver" ;;
		debian-*|dib|toolbox-*) echo "base" ;;
		redis*|memcached*|rabbitmq*|mongo*) echo "cache_queue" ;;
		docker*|linker*) echo "docker" ;;
		*) echo "tools" ;;
	esac
}

get_cluster_label() {
	case "$1" in
		php) echo "PHP" ;;
		database) echo "Databases" ;;
		elasticsearch) echo "Elasticsearch" ;;
		nodejs) echo "Node.js" ;;
		webserver) echo "Web Servers" ;;
		base) echo "Base Images" ;;
		cache_queue) echo "Cache / Queue" ;;
		docker) echo "Docker Tools" ;;
		tools) echo "Other Tools" ;;
	esac
}

# === Collect all images ===

all_images_file="$tmp_dir/all_images.txt"
edges_file="$tmp_dir/edges.txt"
external_file="$tmp_dir/external.txt"

# First pass: collect all our images and edges (exclude _deprecated)
for docker_file in ./*/Dockerfile; do
	# Skip deprecated images
	[[ "$docker_file" == "./_deprecated/"* ]] && continue

	image=$(basename "$(dirname "$docker_file")")
	echo "$image" >> "$all_images_file"

	parent_raw=$(grep '^FROM ' "$docker_file" | awk '{print $2}')
	parent_image=$(echo "$parent_raw" | sed 's/^nfqlt\///' | sed 's/docker\.nfq\.lt\/nfqlt\///' | sed 's/docker\.io\///')

	echo "$parent_image -> $image" >> "$edges_file"

	# Check if parent is external
	if ! grep -q "^${parent_image}$" "$all_images_file" 2>/dev/null; then
		echo "$parent_image" >> "$external_file"
	fi
done

# Deduplicate external images
if [ -f "$external_file" ]; then
	sort -u "$external_file" > "$external_file.sorted"
	mv "$external_file.sorted" "$external_file"

	# Remove any that are actually internal
	while read -r ext; do
		if grep -q "^${ext}$" "$all_images_file" 2>/dev/null; then
			sed -i.bak "/^${ext}$/d" "$external_file"
		fi
	done < "$external_file"
	rm -f "$external_file.bak"
fi

# === Generate Graph ===

{
	echo "digraph $result_file_name {"
	echo '  graph [fontname="Helvetica" pad="0.5" nodesep="0.2" ranksep="0.3" compound=true];'
	echo '  rankdir="LR";'
	echo '  node [style="filled,rounded" shape=box fontname="Helvetica" fontsize=9];'
	echo '  edge [color="#888888" arrowsize=0.7];'
	echo ''

	# Legend subgraph
	echo '  subgraph cluster_legend {'
	echo '    label="Status Legend";'
	echo '    labeljust="l";'
	echo '    style=dashed;'
	echo '    color="#aaaaaa";'
	echo '    fontsize=11;'
	echo '    fontname="Helvetica-Bold";'
	echo '    node [fontsize=8 width=0.8];'
	echo '    legend_active [label="Active" fillcolor="#ccffcc"];'
	echo '    legend_maint [label="Maintenance" fillcolor="#ffffcc"];'
	echo '    legend_eol [label="EOL" fillcolor="#ffcccc"];'
	echo '    legend_external [label="External" fillcolor="white"];'
	echo '    legend_active -> legend_maint -> legend_eol -> legend_external [style=invis];'
	echo '  }'
	echo ''

	# Output clustered nodes
	for cluster in base database php elasticsearch nodejs webserver cache_queue docker tools; do
		cluster_images=""
		while read -r img; do
			img_cluster=$(get_cluster "$img")
			if [ "$img_cluster" = "$cluster" ]; then
				cluster_images="$cluster_images $img"
			fi
		done < "$all_images_file"

		if [ -n "$cluster_images" ]; then
			label=$(get_cluster_label "$cluster")
			echo "  subgraph cluster_$cluster {"
			echo "    label=\"$label\";"
			echo '    labeljust="l";'
			echo '    style="rounded,filled";'
			echo '    fillcolor="#f8f8f8";'
			echo '    color="#cccccc";'
			echo '    fontname="Helvetica-Bold";'
			echo '    fontsize=11;'

			for img in $cluster_images; do
				color=$(get_color "$img")
				echo "    \"$img\" [fillcolor=\"$color\"];"
			done

			echo '  }'
			echo ''
		fi
	done

	# Edges
	echo '  // Dependencies'
	while read -r edge; do
		parent=$(echo "$edge" | cut -d' ' -f1)
		child=$(echo "$edge" | cut -d' ' -f3)
		echo "  \"$parent\" -> \"$child\";"
	done < "$edges_file"

	echo ''

	# Style external images
	echo '  // External base images'
	if [ -f "$external_file" ]; then
		while read -r ext; do
			if [ -n "$ext" ]; then
				echo "  \"$ext\" [fillcolor=white style=\"filled,rounded,dashed\"];"
			fi
		done < "$external_file"
	fi

	echo '}'
} > "$gv_file"

# Generate outputs
echo "Generating graph..."
dot -Tpng -Gdpi=150 "$gv_file" -o "$png_file" 2>/dev/null
dot -Tsvg "$gv_file" -o "$svg_file" 2>/dev/null

echo "Generated:"
echo "  $gv_file"
echo "  $png_file"
echo "  $svg_file"

# Stats
total=$(wc -l < "$all_images_file" | tr -d ' ')
eol_count=0
maint_count=0
active_count=0

while read -r img; do
	if is_eol "$img"; then
		eol_count=$((eol_count + 1))
	elif is_maintenance "$img"; then
		maint_count=$((maint_count + 1))
	else
		active_count=$((active_count + 1))
	fi
done < "$all_images_file"

echo ""
echo "Statistics:"
echo "  Total images:  $total"
echo "  Active:        $active_count (green)"
echo "  Maintenance:   $maint_count (yellow)"
echo "  EOL:           $eol_count (red)"
