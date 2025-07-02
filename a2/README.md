CSV Dataset Analysis and Summary Generator

The datacollecter.sh script asks for a URL as user input. 
If the URL has a .zip , the script unzips the URL and download the files and create a summary.md for .csv files. 
The summary files calculate  min, max, mean and std deviation of each of the numerical columns in the .csv files.

Commands Used

read 
this command will read the user input

curl -s -O -
this command is used to donwload the URL
the -s stands for the silent mode,
the -O stands for remote name, meaning the file will be saved using the name on the remote server

awk -F';' 'NR == 1 {
    for (i=1; i<=NF; i++) {
        header[i] = $i
    }
}'
this command will check if the number of records is 1. If it is, it will enter the for loop and populate the headers with the feature or column values. 



        NR > 1 {
            for (i=1; i<=NF; i++) {
                sum[i] += $i
                count[i]++
                if (NR == 2 || $i > max[i]) max[i] = $i
                if (NR == 2 || $i < min[i]) min[i] = $i
                sum_sq[i] += $i * $i
            }
        }

this command will sum up the records for feature i and for initialize a value to calculate max and min. 

        END {
        
            for (i=1; i<=NF; i++) {
                mean = sum[i] / count[i]
                stddev = sqrt((sum_sq[i] / count[i]) - (mean * mean)) # Standard deviation formula
                print "Feature: "  i ": " header[i] ": Sum = " sum[i] ", Mean = " mean ", Max = " max[i] ", Min = " min[i] ", StdDev = " stddev
            }
        }' "$file" > "$summary_file"  # Output to a summary file specific to each CSV
    done 

this will print out the summary analysis and store them in the respective .csv file

this is the summary analysis output after running the script on winequality-red.md

nyi_tun@cs131-a1:~/cs131su25/a2/dataset$ cat summary_winequality-red.md
Feature: 1: "fixed acidity": Sum = 13303.1, Mean = 8.31964, Max = 15.9, Min = 4.6, StdDev = 1.74055
Feature: 2: "volatile acidity": Sum = 843.985, Mean = 0.527821, Max = 1.58, Min = 0.12, StdDev = 0.179004
Feature: 3: "citric acid": Sum = 433.29, Mean = 0.270976, Max = 1, Min = 0, StdDev = 0.19474
Feature: 4: "residual sugar": Sum = 4059.55, Mean = 2.53881, Max = 15.5, Min = 0.9, StdDev = 1.40949
Feature: 5: "chlorides": Sum = 139.859, Mean = 0.0874665, Max = 0.611, Min = 0.012, StdDev = 0.0470506
Feature: 6: "free sulfur dioxide": Sum = 25384, Mean = 15.8749, Max = 72, Min = 1, StdDev = 10.4569
Feature: 7: "total sulfur dioxide": Sum = 74302, Mean = 46.4678, Max = 289, Min = 6, StdDev = 32.885
Feature: 8: "density": Sum = 1593.8, Mean = 0.996747, Max = 1.00369, Min = 0.99007, StdDev = 0.00188674
Feature: 9: "pH": Sum = 5294.47, Mean = 3.31111, Max = 4.01, Min = 2.74, StdDev = 0.154338
Feature: 10: "sulphates": Sum = 1052.38, Mean = 0.658149, Max = 2.0, Min = 0.33, StdDev = 0.169454
Feature: 11: "alcohol": Sum = 16666.3, Mean = 10.423, Max = 14.9, Min = 8.4, StdDev = 1.06533
Feature: 12: "quality": Sum = 9012, Mean = 5.63602, Max = 8, Min = 3, StdDev = 0.807317 

 
