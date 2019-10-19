#!/bin/bash
#$ -l highp
#$ -l h_rt=01:00:00
#$ -l h_data=2G
#$ -N job_name
#$ -cwd
#$ -o stdout.$JOB_ID
#$ -e stderr.$JOB_ID
#$ -pe dc* 8

# put your commands below, e.g.
source /u/local/Modules/default/init/modules.sh
module load intel/18.0.3
date
which mpirun
mpirun -n $NSLOTS hostname
