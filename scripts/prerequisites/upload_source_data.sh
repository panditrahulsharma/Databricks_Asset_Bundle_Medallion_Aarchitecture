#!/bin/bash
set -e


ZIP=./docs/JC-202503-citibike-tripdata.csv.zip
TMP=./docs/citibike/
ENVS=("dev" "test" "prod")

# unzip once
rm -rf "$TMP"
unzip -o "$ZIP" -d "$TMP"

for ENV in "${ENVS[@]}"; do
  export DATABRICKS_CONFIG_PROFILE="$ENV"
  echo "📤 Uploading data to environment: $ENV"

  DEST="dbfs:/Volumes/citibike_${ENV}/00_landing/source_citibike_data/"

  databricks fs cp \
    "$TMP"/*.csv \
    "$DEST" \
    --overwrite
done

# cleanup
rm -rf "$TMP"

echo "✅ Upload completed for dev, test, prod"
