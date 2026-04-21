#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT_DIR="$ROOT_DIR/server/functions/src/models.pb"
PROTO_DIR="$ROOT_DIR/protos"
TS_PROTO_PLUGIN="$ROOT_DIR/server/functions/node_modules/.bin/protoc-gen-ts_proto"

echo "----------------------------------------"
echo "Generating models.pb for semur-engine"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
find "$PROTO_DIR" -name "*.proto" -print0 | xargs -0 protoc -I="$PROTO_DIR" --plugin="$TS_PROTO_PLUGIN" --ts_proto_out="$OUTPUT_DIR"
echo "############################################"
echo "Finished generating models.pb for semur-engine"
