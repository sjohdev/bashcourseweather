#! /bin/bash
# This script analyzes the forecast accuracy of the last 7 days: 

# Load weekly data into array: 
fcErrors=($(tail -n 7 synthetic_historical_fc_accuracy.tsv | cut -f 6 ))

# Validate the array by displaying each array element: 
echo "Errors of the week: "
echo "${fcErrors[@]}"

# Determine the min and max absolute errors: 
# Convert from signed to absolute errors:
for i in {0..6}; do
  if [[ ${fcErrors[$i]} -lt 0 ]]
  then
    fcErrors[$i]=$(((-1)*fcErrors[$i]))
  fi
done
#echo "${fcErrors[@]}"

# Initialize min/max variables:
min=${fcErrors[0]}
max=${fcErrors[0]}

# Find min and max values: 
for item in ${fcErrors[@]}; do
	if [[ $min -gt $item ]]
	then
		min=$item
	fi
	if [[ $max -lt $item ]]
	then
		max=$item
	fi
done

# Display final result: 
echo "Min absolute error of the week: $min C"
echo "Max absolute error of the week: $max C"
