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

# Check only the files we actually generate
# Note: Only check files that exist (some levels may be empty)
# Skip PNG - graphviz produces different binary output across environments
generated_patterns="_tools/gitlab/level_*/config.yml \
_docs/media/image_relations.gv \
_docs/media/image_relations.svg"

changes=""
for pattern in $generated_patterns; do
	for file in $pattern; do
		if [ -f "$file" ] && ! git diff --exit-code "$file" >/dev/null 2>&1; then
			changes="$changes $file"
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
	echo "Showing first 50 lines of diff for debugging:"
	git diff $changes | head -50
	echo ""
	echo "Please run locally:"
	echo "  bash _tools/regenerate-all.sh"
	echo ""
	echo "Then commit the changes."
	exit 1
fi

echo "✅ All generated configs are up to date!"
