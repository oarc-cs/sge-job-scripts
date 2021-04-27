#!/bin/bash
#$ -l h_rt=8:00:00,h_data=8G,arch=intel*
#$ -cwd
#$ -N jupyter-c6
#$ -j y
#
# Please see the instructions in "nb6.md"

unset XDG_RUNTIME_DIR
source /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.02

# To run notebook INSECURELY without password/token, add: --NotebookApp.token='' --NotebookApp.password=''
# The actual port number may be different, since Jupyter automatically retries (see --port-retries)

jupyter-notebook --ip=$(hostname -i | awk '{print $1}') --port=12345 --no-browser --notebook-dir=$HOME


