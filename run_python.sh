#!/bin/bash
#
# An example of submitting a job to run a Python code (my_py_code.py) that is
# placed in the current directory with this script. Adjust the job parameters
# (h_rt, h_data) accordingly.
#
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -N run_py
#$ -cwd
#$ -o stdout.$JOB_ID
#$ -e stderr.$JOB_ID

source /u/local/Modules/default/init/bash
module load anaconda3/2019.03
python my_py_code.py

