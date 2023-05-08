#!/bin/bash

interval=1 # N of seconds between memory queries
nJobs=10 # N top jobs per memory usage to track
base_filename=mem


while getopts n:t: flag
do
    case "${flag}" in
        t) interval=${OPTARG};;
        n) nJobs=${OPTARG};;
    esac
done



i=0

echo "Step MemFraction VirtMem ResMem pid" > "$base_filename.dat" 

echo "Step Memory" > "${base_filename}_sys.dat"


while [ 1 ]


do
    # saves memory usage per process from ps
    ps aux | sort -k 4 -r > .tmp.dat  
    head -n $((nJobs + 1)) .tmp.dat | tail -n $nJobs | awk "{print $i,\$4,\$5,\$6,\$2 }" >> "${base_filename}.dat"
    
    # saves system wide memory usage
    free --kilo | grep Mem | awk "{print $i,\$3}" >> "${base_filename}_sys.dat"
    sleep $interval

    i=$((i+interval))
    
done
