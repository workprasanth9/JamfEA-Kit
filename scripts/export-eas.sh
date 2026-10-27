#!/bin/bash
# Export every EA as Jamf Pro importable XML and JSON into dist/export.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/dist/export}"
"$ROOT/bin/jamfea" export --format xml --out "$OUT/xml"
"$ROOT/bin/jamfea" export --format json --out "$OUT/json"
"$ROOT/bin/jamfea" export --format json > "$OUT/jamfea-kit-all.json"
echo "Exports written to $OUT"
