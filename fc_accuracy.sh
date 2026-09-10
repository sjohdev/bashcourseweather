#! /bin/bash

# Extract temperature data from logfile and present it in the standard output: 
tempObs=$(tail -n 1 rx_poc.log  | cut -f 4 | grep -oE "[0-9]+")
tempFc=$(tail -n 2 rx_poc.log | head -n 1 | cut -f 6 | grep -oE "[0-9]+")
fcError=$(($tempFc-$tempObs))

echo "Todays temp is: $tempObs C"
echo "Yesterdays forecast of today was: $tempFc C"
echo "Forecast error was: $fcError C"

# Grade the accuracy on a scale from poor-excellent: 
if [ -1 -le $fcError ] && [ $fcError -le 1 ]
then
	fclabel='Excellent'
elif [ -2 -le $fcError ] && [ $fcError -le 2 ]
then 
	fclabel='Good'
elif [ -3 -le $fcError ] && [ $fcError -le 3 ]
then
	fclabel='Fair'
else
	fclabel='Pooooor'
fi
echo "Forecast accuracy was: $fclabel"

# Log the Forecast accuracy in historical_fc_accuracy.tsv:
row=$(tail -1 rx_poc.log)
year=$( echo $row | cut -d " " -f1)
month=$( echo $row | cut -d " " -f2)
day=$( echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$tempObs\t$tempFc\t$fcError\t$fclabel" >> historical_fc_accuracy.tsv

