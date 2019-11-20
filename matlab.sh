#!/bin/bash
# uncomment this (highp) line to run on your purchased node
##$ -l highp
#
#$ -l h_rt=24:00:00,h_data=128G
#$ -N matlab
#$ -cwd
#$ -j y

# Load the matlab environment
source /u/local/Modules/default/init/modules.sh
module load matlab/9.7

# show the matlab version (for confirmation)
matlab -batch version

# run matlab code (svd.m) in this directory
# disable graphical display to save computing resources

matlab -nojvm -nodisplay -nosplash -singleCompThread  < svd.m

