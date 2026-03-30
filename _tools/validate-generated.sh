#!/bin/bash
#
# Validate that generated configs are up to date
#
# Used in CI to ensure developers regenerated configs after adding/removing images
#

set -e

cd "$(dirname "$(dirname "$(realpath "$0")")")"

echo "==> Regenerating configs to check if they're up to date..."
bash _tools/generate_gitlab_pipelines.sh
bash _tools/graph-gen.sh

echo ""
echo "==> Checking for differences..."

# Save generated files to temp location for comparison
tmp_gen="$(mktemp -d)"
trap "rm -rf $tmp_gen" EXIT

# Check only the files we actually generate
# Note: Only check files that exist (some levels may be empty)
# Skip PNG - graphviz produces different binary output across environments
generated_patterns="_tools/gitlab/level_*/config.yml \
_docs/media/image_relations.gv \
_docs/media/image_relations.svg"

# Copy newly generated files
for pattern in $generated_patterns; do
	for file in $pattern; do
		if [ -f "$file" ]; then
			mkdir -p "$tmp_gen/$(dirname "$file")"
			cp "$file" "$tmp_gen/$file"
		fi
	done
done

# Restore original files from git
git checkout HEAD -- _tools/gitlab/ _docs/media/ 2>/dev/null || true

# Compare files
changes=""
for pattern in $generated_patterns; do
	for file in $pattern; do
		if [ -f "$file" ] && [ -f "$tmp_gen/$file" ]; then
			if ! diff -q "$file" "$tmp_gen/$file" >/dev/null 2>&1; then
				changes="$changes $file"
			fi
		fi
	done
done

# Restore generated files
for pattern in $generated_patterns; do
	for file in $pattern; do
		if [ -f "$tmp_gen/$file" ]; then
			cp "$tmp_gen/$file" "$file"
		fi
	done
done

if [ -n "$changes" ]; then
	echo ""
	echo "❌ ERROR: Generated configs are out of sync!"
	echo ""
	echo "The following generated files have changes:"
	for file in $changes; do
		echo "  - $file"
	done
	echo ""
	echo "Showing diff samples for debugging:"
	for file in $changes; do
		echo "=== $file (first 30 lines) ==="
		diff -u "$file" "$tmp_gen/$file" 2>/dev/null | head -30 || echo "  (diff unavailable)"
		echo ""
	done
	echo ""
	echo "Please run locally:"
	echo "  bash _tools/regenerate-all.sh"
	echo ""
	echo "Then commit the changes."
	exit 1
fi

echo "✅ All generated configs are up to date!"
