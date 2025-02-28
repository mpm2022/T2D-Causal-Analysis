#!/bin/bash

current_dir="$(pwd)"
parent_dir="$(dirname "$current_dir")"

# manifest.tsv will be saved in the current directory
output_manifest="$current_dir/manifest.tsv"

# Header
echo -e "sample-id\tabsolute-filepath" > "$output_manifest"

# Find all .fastq files in the current directory
find "$parent_dir" -type f -name "*.fastq" | while read -r file; do
    filename=$(basename "$file")

    # Remove _1.fastq and .fastq from the filename to get the sample-id
    sample_id="${filename/_1.fastq/}"
    sample_id="${sample_id/.fastq/}"

    # Write the sample-id and absolute path to the manifest
    echo -e "$sample_id\t$file" >> "$output_manifest"
done

echo "Manifest file 'manifest.tsv' created successfully in the current directory!"
