#! /bin/bash

tempobs=$(tail -n 1 rx_poc.log  | cut -f 4 | grep -oE "[0-9]+")
tempfc=$(tail -n 2 rx_poc.log | head -n 1 | cut -f 6 | grep -oE "[0-9]+")

echo "Todays temp is: $tempobs C"
echo "Yesterdays forecast of today was: $tempfc C"
