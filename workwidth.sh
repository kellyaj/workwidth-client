#!/bin/bash

timestampDelimiter='----'
startDate=`date +%s`
startDateHuman=`date +%Y-%m-%d-%T`
startingMeasure=`netstat -I en0 -ib | awk '{print $7,$10}' | tail -1`
sessionFileName="ww-${startDateHuman}.txt"
printf "creating session file ${sessionFileName}\n"
touch $sessionFileName
echo $startDate >> $sessionFileName
echo "$startingMeasure" >> $sessionFileName
echo $timestampDelimiter >> $sessionFileName
