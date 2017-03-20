#!/bin/bash
#
# SGE job script: sequential job (using only 1 CPU core)
#

#$ -j y
#$ -o stdout.$JOB_ID
#$ -cwd
#$ -l h_data=2G,h_rt=24:00:00

# Please note:
# - The h_data value cannot exceed the physical memory size of the
#   compute node being requested. 
# - Add additional 'module load' as needed

source /u/local/Modules/default/init/modules.sh
module load intel
module load python

# source your own startup script if needed
# source ~/.bash_profile

# run the executable
./a.out

