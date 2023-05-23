# Check_mem 
Simple script to monitor memory usage on a node. By default collects the total memory used on a node. However it accepts an option to collect memory per process ( by parsing the output of ps ) and filtering only processors with a memory usage above a certain thresold. All memory units are in KB.
You can find a more detailed description by typing 
```bash 
bash check_mem.sh -h
```
## Running on muliple nodes 
If you are using multiple nodes you need to launch the job on multiple nodes. You many need to oversubscribe the node. You can find an example script below for the SLURM scheduler

```
#!/bin/bash

#SBATCH --job-name=MY_JOB_NAME
#SBATCH --time=00:09:00
#SBATCH --exclusive
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=1
#SBATCH --partition=standard
#SBATCH --qos=short


export OMP_NUM_THREADS=1

srun --oversubscribe --mem=1GB  --ntasks=2 --ntasks-per-node=1 --nodes=2  bash -c './check_mem.sh -t 1 > mem_${SLURMD_NODENAME}' &
srun --oversubscribe --mem=250GB ./my_exec


```

