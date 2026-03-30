#!/bin/bash
#
# Regenerate all generated configs and documentation
#
# Usage: bash _tools/regenerate-all.sh
#

set -e

cd "$(dirname "$(dirname "$(realpath "$0")")")"

echo "==> Regenerating GitLab CI pipeline configs..."
bash _tools/generate_gitlab_pipelines.sh

echo ""
echo "==> Regenerating image dependency graph..."
bash _tools/graph-gen.sh

echo ""
echo "==> Done! Generated files:"
echo "  - _tools/gitlab/level_*/config.yml"
echo "  - _docs/media/image_relations.{gv,png,svg}"
echo ""
echo "Review changes with: git diff _tools/gitlab/ _docs/media/"
