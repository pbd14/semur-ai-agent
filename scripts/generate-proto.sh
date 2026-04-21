#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "----------------------------------------"
echo "Generating models.pb for tracked Semur backend"
"$ROOT_DIR/server/scripts/generate-proto.sh"
echo "############################################"
echo "Finished generating tracked server models"
