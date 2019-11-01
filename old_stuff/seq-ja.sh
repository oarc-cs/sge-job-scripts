#!/bin/bash
#
# SGE job script: sequential job array
#

#$ -j y
#$ -o stdout.$JOB_ID.$SGE_TASK_ID
#$ -cwd
#$ -l h_data=2G,h_rt=24:00:00
#$ -t 1-10

# Please note:
# - The h_data value cannot exceed the physical memory size of the
#   compute node being requested. 
# - Each job has the same job number but a different task ID
#   (environment variable $SGE_TASK_ID defined at runtime).
#   The range of the task IDs is set by the "-t" option above.
# - Add additional 'module load' as needed
# - Replace 'a.out' with the actual executable file name

source /u/local/Modules/default/init/modules.sh
module load intel
module load python

# source your own startup script if needed
# source ~/.bash_profile

# run the executable
./a.out $SGE_TASK_ID

