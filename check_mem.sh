#!/bin/bash

set -e 

interval=1 # N of seconds between memory queries
nJobs=10 # N top jobs per memory usage to track
base_filename=mem
record_per_process=0

usage=$"$(basename "$0") [-h] [-t n] \n

where: \n
    -h show this help text \n
    -t sampling interval in seconds. Must be an integer \n
    -p record memory per process
"

while getopts pt:h flag
do
    case "${flag}" in
        t)  interval=${OPTARG};;
        h)  echo -e $usage 1>&2
            exit 1
            ;;
        p) record_per_process=1 ;;


    esac
done




if [ $record_per_process == 1 ]
then 
    echo "Step Memory Pid Name" > "$base_filename.dat" 
else
    echo "Step Memory" > "${base_filename}_sys.dat"
fi

i=1
while [ 1 ]
do
    if [ $record_per_process == 1 ]
    then
    # saves memory usage per process from ps
        ps -F | tail -n +2 | awk "{print $i,\$6,\$2,\$11 }"  >> "${base_filename}.dat"
    else
    # saves system wide memory usage
        free --kilo | grep Mem | awk "{print $i,\$3}" >> "${base_filename}_sys.dat"
    fi
    sleep $interval

    i=$((i+interval))
    
done
