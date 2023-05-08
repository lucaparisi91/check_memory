
interval=10
nJobs=10
i=0
filename=mem.dat

while [ 1 ]
echo "Step MemFraction VirtMem ResMem pid" > $filename
do
    ps aux | sort -k 4 -r > tmp.dat  
    head -n $((nJobs + 1)) tmp.dat | tail -n $nJobs | awk "{print $i,\$4,\$5,\$6,\$2 }" >> $filename
    sleep $interval
    rm tmp.dat
    i=$((i+interval))

done
