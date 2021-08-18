# Running Jupyter Notebook on the compute node

The job script `nb6.sh` enables you to launch a jupyter notebook on the
CentOS 6 compute node that can be connected your local computer's browser
using ssh port forwarding via Hoffman2 cluster's login node (login1 in 
the following example). While the script itself is short, additional commands
need to be issued, as instructed below.

## Step 1

Modify the job script, `nb6.sh`, such as the run time `h_rt`, memory size `h_data`, the
`module load` (to load all othe modules your jupyter notebook will need at 
runtime) to your liking. Then submit the job by the command:

```
$ qsub nb6.sh        # on Hoffman2 cluster
```

Wait for the job to start.

## Step 2


Confirm that the job has started (on compute node nXXXX), i.e. in "r" state as 
shown by either the command `qstat -u $USER` or `myjobs`.

On Hoffman2 login node, run the command:

```
get-jupyter-port JOB_ID
```

and follow the screen instructions. `JOB_ID` is your actual job number (e.g. `get-jupyter-port 99999` if 99999 is your job ID).



## Step 3

At this point, if you can see your Hoffman2 directory listing in the notebook,
it means the notebook has been successfully connected to your local web browser.

Now enjoy Jupyter notebook computing!

## Step 4 (After your are done)

1. Kill the job (e.g. `qdel job_id` where "job_id" is the job number) if it is still running on Hoffman2 cluster.
2. Terminate the "ssh" processes on your local computer (e.g. by closing the terminal)


## Additional information:

In the port forwarding command syntax, `ssh -f -N -L PPPP:nXXX:QQQQ ...`,
the first number PPPP is your local computer's port, and the second number QQQQ is
the port number of Hoffman2's compute node running Jupyter notebook (as shown
by the "jupyter notebook list" command above). In case your local port is not
available, you can simply try a new port number, e.g. changing it to `11112` (instead of `11111`):

```
 $ ssh -f -N -L 11112:nXXX:12345    # on local computer
```

In this case, `11112` is your local port number, so point your browser to `http://localhost:11112` instead to connect to the notebook.


## Alternative approach

(Thanks to Qiyang for suggesting this approach.)

It is possible to create a jupyter kernel that automatically loads a particular conda environment. 
For example, the following kernel "pegasus" will load the conda environment "pegasus":

```bash
$ module load anaconda3
$ source $CONDA_DIR/etc/profile.d/conda.sh
$ conda activate pegasus
(pegasus) $ conda install ipykernel   # if not installed
(pegasus) $ python -m ipykernel install --user --name=pegasus
$ conda deactivate
```

The "pegasus" kernel will show up in the kernel list of a Jupyter notebook, e.g.

![image](/uploads/7b4cabb1779b9db56872079309a656e3/image.png)