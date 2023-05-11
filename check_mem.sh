#!/bin/bash

set -e 

interval=1 # N of seconds between memory queries
nJobs=10 # N top jobs per memory usage to track
base_filename=mem

usage=$"$(basename "$0") [-h] [-t n] \n

where: \n
    -h show this help text \n
    -t sampling interval in seconds. Must be an integer \n
"

while getopts t:h flag
do
    case "${flag}" in
        t)  interval=${OPTARG};;
        h)  echo -e $usage 1>&2
            exit 1
            ;;

    esac
done



i=0

echo "Step Memory Pid Name" > "$base_filename.dat" 

echo "Step Memory" > "${base_filename}_sys.dat"


while [ 1 ]

do
    # saves memory usage per process from ps

    ps -F | tail -n +2 | awk "{print $i,\$6,\$2,\$11 }"  >> "${base_filename}.dat"

    # saves system wide memory usage
    free --kilo | grep Mem | awk "{print $i,\$3}" >> "${base_filename}_sys.dat"
    sleep $interval

    i=$((i+interval))
    
done
