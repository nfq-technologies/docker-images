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

if ! git diff --exit-code _tools/gitlab/ _docs/media/ >/dev/null 2>&1; then
	echo ""
	echo "❌ ERROR: Generated configs are out of sync!"
	echo ""
	echo "The following files have changes:"
	git diff --name-only _tools/gitlab/ _docs/media/
	echo ""
	echo "Please run locally:"
	echo "  bash _tools/regenerate-all.sh"
	echo ""
	echo "Then commit the changes."
	exit 1
fi

echo "✅ All generated configs are up to date!"
