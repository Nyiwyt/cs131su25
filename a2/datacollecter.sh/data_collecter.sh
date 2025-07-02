#!/bin/bash

echo "Please enter the URL to your CSV file:"
read url

mkdir -p dataset
cd dataset  # Change the current directory to dataset

filename=$(basename "$url")
curl -s -O "$url"  # Download the CSV file (or zip)

if [[ "$filename" == *.zip ]]; then
    unzip "$filename"  # Unzip if it's a .zip file
    csv_files=$(ls *.csv)
else
    csv_files="$filename"  # If not a zip, the CSV file is already downloaded
fi


if [[ -n "$csv_files" ]]; then
    for file in $csv_files; do
        # Create a summary.md file for each CSV
        summary_file="summary_${file%.csv}.md"

        # Run AWK command to generate statistics for each file
        awk -F';' 'NR == 1 {
            # Store header values (column names)
            for (i=1; i<=NF; i++) {
                header[i] = $i
            }
        }
        NR > 1 {
            # Sum each column, count the rows, track max & min, and calculate  squared standard deviation
            for (i=1; i<=NF; i++) {
                sum[i] += $i
                count[i]++
                if (NR == 2 || $i > max[i]) max[i] = $i
                if (NR == 2 || $i < min[i]) min[i] = $i
                sum_sq[i] += $i * $i
            }
        }
        END {
            # Print index, sum, mean, max, min, and standard deviation for each column using header names
            for (i=1; i<=NF; i++) {
                mean = sum[i] / count[i]
                stddev = sqrt((sum_sq[i] / count[i]) - (mean * mean)) # Standard deviation formula
                print "Feature: "  i ": " header[i] ": Sum = " sum[i] ", Mean = " mean ", Max = " max[i] ", Min = " min[i] ", StdDev = " stddev
            }
        }' "$file" > "$summary_file"  # Output to a summary file specific to each CSV
    done
fi

