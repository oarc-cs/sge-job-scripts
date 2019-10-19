#!/bin/bash
#$ -l h_rt=01:00:00
#$ -l h_data=2G
#$ -N job_name
#$ -cwd
#$ -o stdout.$JOB_ID
#$ -e stderr.$JOB_ID
#$ -pe dc* 8

# put your commands below, e.g.
date

