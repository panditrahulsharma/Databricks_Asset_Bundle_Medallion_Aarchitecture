#!/bin/bash
set -euo pipefail

ZIP=./docs/JC-202503-citibike-tripdata.csv.zip
TMP=./docs/citibike

# -------------------------------------------------
# Validate input
# -------------------------------------------------
if [ "$#" -eq 0 ]; then
  echo "❌ No environments provided"
  echo "Usage: $0 <env1> [env2 ...]"
  exit 1
fi

ENVS=("$@")

echo "📦 Unzipping source data..."
rm -rf "$TMP"
unzip -o "$ZIP" -d "$TMP"

# -------------------------------------------------
# Upload for each environment
# -------------------------------------------------
for ENV in "${ENVS[@]}"; do
  echo "📤 Uploading data to environment: $ENV"

  DEST="dbfs:/Volumes/citibike_${ENV}/00_landing/source_citibike_data/"

  databricks fs cp \
    "$TMP"/*.csv \
    "$DEST" \
    --overwrite \
    --profile "$ENV"

done

# -------------------------------------------------
# Cleanup
# -------------------------------------------------
rm -rf "$TMP"

echo "✅ Upload completed for environments: ${ENVS[*]}"
