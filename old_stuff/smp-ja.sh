#!/bin/bash
#
# SGE job script: multi-core/SMP job array
#

#$ -j y
#$ -o stdout.$JOB_ID
#$ -cwd
#$ -l h_data=2G,h_rt=24:00:00
#$ -pe shared 8
#$ -t 1-10

# Please note:
# - Number of slots (-pe) cannot exceeds the total number of CPU cores of the
#   compute node being requested
# - (number of slots)*(h_data) cannot exceeds the total physical memory size
#   of the compute node being requested
# - Add additional 'module load' as needed
# - Replace 'a.out' with the actual executable file name

source /u/local/Modules/default/init/modules.sh
module load intel
module load python

# source your own startup script if needed
# source ~/.bash_profile

# run the executable
export OMP_NUM_THREADS=$NSLOTS
./a.out $SGE_TASK_ID

