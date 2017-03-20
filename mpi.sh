#!/bin/bash
#
# SGE job script: distributed-memory/MPI job (using multiple compute nodes)
#

#$ -j y
#$ -o stdout.$JOB_ID
#$ -cwd
#$ -l h_data=2G,h_rt=24:00:00
#$ -pe dc* 8

# Please note:
# - Number of slots (-pe) cannot exceeds the total number of CPU cores of the
#   compute node being requested
# - Add additional 'module load' as needed

source /u/local/Modules/default/init/modules.sh
module load intel
module load python

# source your own startup script if needed
# source ~/.bash_profile

# run the executable
mpirun -np $NSLOTS ./a.out

