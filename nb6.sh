#!/bin/bash
#$ -l h_rt=8:00:00,h_vmem=infinity,h_data=8G,arch=intel*
#$ -cwd
#$ -N jupyter-c6
#$ -j y
#
#----------------------------------------------------------------------------
#
# Running a jupyter notebook on the CentOS 6 compute node that can be
# connected your local computer's browser via port forwarding via Hoffman2
# cluster's login node (login1 in the following example)
#
# Step 1
#=========
#
# Modify the "module load ..." command below to load all othe modules your
# jupyter notebook will need. Submit this job by the command:
#
# $ qsub nb6.sh
#
# Step 2
#=========
#
# After the job is started (on compute node nXXXX), as shown by
#
#  $ qstat -u $USER
#
# Run this command on the login node:
#
#  $ ssh nXXXX jupyter notebook list
#
# The output will look like:
# http://XXX.XX.XXX.XXX:12345/?token=dee346608015366d1be7f2dd69743e83cc3578e34476c2cd :: /u/home/...
#
# We will need the port number i.e. "12345" and the token "dee34...2cd"
#  in the next step.
#
# NOTE: the port number in the last command above could be different from "--port=12345"
# since Jupyter will automatically retry to find available ports. Always the port number
# given by "jupyter notebook list".
#
# Step 3
#=========
#
# On your local computer, run the command (or the equivalent on Windows), e.g.
#
#  $ ssh -f -N -L 12345:nXXX:12345 user_name@login1.hoffman2.idre.ucla.edu
#
#  (adjust the port number accordingly. See also "Additional Information" below.)
#
# Now point your web browser at: http://localhost:12345
#
# When prompted, enter token sting from above, e.g.
#   "dee346608015366d1be7f2dd69743e83cc3578e34476c2cd" (without the quote)
#
#
# After your are done:
# 1. Kill the job (qdel $job_id) if it is still running on Hoffman2 cluster.
# 2. kill the "ssh" processes on your local computer.
#
#
# Additional information:
#
# - In the port forwarding command, "ssh -f -N -L 12345:nXXX:12345 ...",
# the first number is your local computer's port, and the second number is
# the port number of Hoffman2's compute node running Jupyter notebook (as shown
# by the "jupyter notebook list" command above). In case your local port is not
# available, you can simply try a new port number, e.g. changing it to 12348:
#
# $ ssh -f -N -L 12348:nXXX:12345
#----------------------------------------------------------------------------

unset XDG_RUNTIME_DIR
source /u/local/Modules/default/init/modules.sh
module load anaconda3/2020.02
#which jupyter-notebook

# uncomment the "token" and "password" options below if you want to run jupyter notebook INSECURELY
jupyter-notebook --ip=$(hostname -i | awk '{print $1}') --port=12345 --no-browser --notebook-dir=$HOME \
                 #--NotebookApp.token='' #--NotebookApp.password=''

