# Check_mem 
Simple script to monitor memory usage on a node. By default collects the total memory used on a node. However it accepts an option to collect memory per process ( by parsing the output of ps ) and filtering only processors with a memory usage above a certain thresold. All memory units are in KB.
You can find a more detailed description by typing 
```bash 
bash check_mem.sh -h
```