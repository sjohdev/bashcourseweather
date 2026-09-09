#! /bin/bash
# This script extracts data from a weather report/forecast into a more concise report: 

city=casablanca
curl -s wttr.in/$city > rawrep
tempnow=$(grep -m 1 "°" rawrep | grep -oE "m\+?[0-9]+.*°" | grep -oE "[0-9]+.\[" | grep -m 1 -oE "[0-9]+")
echo "Temp in $city is: $tempnow Celsius"

# Extract forecast for tomorrow: 
tempfc=$(grep -m 3 "°" rawrep | cut -d "C" -f 2 | grep -oE "m\+?[0-9]+.*°" | grep -oE "[0-9]+.\[" | grep -m 1 -oE "[0-9]+")
echo "Temp forecast for $city is: $tempfc Celsius"
