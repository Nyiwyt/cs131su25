#Assignment Instructions
#Stores the sum of grades for each student in an associative array.
#Calculates the average grade for each student and classifies them as Pass (average ≥ 70) or Fail. (Must use a user-defined function to calculate the average.)
#Determine the highest and lowest scoring students (total score)
#Print the following for each student at the end
#Student name
#Total score
#Average score
#Status (pass/fail)
#Also, print the top and lowest scoring students#

function calculate_average(sum_of_score, num_of_score) {
    average = sum_of_score / num_of_score
    status = (average >= 70) ? "Pass" : "Fail"
    result_array["average"] = average
    result_array["status"] = status
}

BEGIN {
    FS = ","
}

NR > 1 {
    student_name = $2
    sum_of_score = $3 + $4 + $5
    num_of_score = 3

    calculate_average(sum_of_score, num_of_score)

    total_score[student_name] = sum_of_score
    student_avg[student_name] = result_array["average"]
    student_status[student_name] = result_array["status"]
}

END {
    for (student_name in total_score) {
        print "Student Name: " student_name
        print "Total Score: " total_score[student_name]
        print "Average Score: " student_avg[student_name]
        print "Status: " student_status[student_name]
    }

    highest_score = -1
    lowest_score = 999999
    for (student_name in total_score) {
        if (total_score[student_name] > highest_score) {
            highest_score = total_score[student_name]
            top_student = student_name
        }
        if (total_score[student_name] < lowest_score) {
            lowest_score = total_score[student_name]
            lowest_student = student_name
        }
    }

    print "Student with highest score:  " top_student " with total score: " highest_score
    print "Student with lowest score: " lowest_student " with total score: " lowest_score
}


