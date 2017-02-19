#!/bin/bash
startDateHuman=`date +%Y-%m-%d-%T`
sessionFileName="ww-${startDateHuman}.txt"

function initializeSession {
  printf "creating session file ${sessionFileName}\n"
  touch $sessionFileName
  printf "adding initial reading to ${sessionFileName}\n"
  startingMeasure=$(takeMeasure)
  echo "$startingMeasure" >> $sessionFileName
}

function takeMeasure {
  timestamp=$(date +%s)
  rawMeasure=`netstat -I en0 -ib | awk '{print $7,$10}' | tail -1`
  currentIn=$(echo $rawMeasure | cut -d " " -f 1)
  currentOut=$(echo $rawMeasure | cut -d " " -f 2)
  echo "{\"timestamp\":\"${timestamp}\", \"in\":\"${currentIn}\", \"out\":\"${currentOut}\"}"
}

function runMeasureLoop {
  (while true; do sleep 60 && echo $(takeMeasure) >> $sessionFileName; done)&
  echo $!
}

initializeSession
runMeasureLoop
