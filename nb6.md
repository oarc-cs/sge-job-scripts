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

In the terminal on the local computer, and issue the command:

```
$ ssh nXXX /u/local/apps/anaconda3/2020.02/bin/jupyter notebook list  # on local computer
```

The output will look like:
 
``` 
 http://XXX.XX.XXX.XXX:12345/?token=dee346608015366d1be7f2dd69743e83cc3578e34476c2cd :: /u/home/...
```

We will need this information in the next steps, in particular, the port 
number i.e. `12345` and the token `dee34...2cd`. You may see multiple entries
if you are running multiple notebooks on the same compute node.
 

 **NOTE**: the port number in the last command above could be different from
 the `--port=12345` option specified in the job script, since Jupyter will 
 automatically retry to find available ports. Always the port number
 given by `jupyter notebook list` command.

## Step 3

On your local computer, open a terminal to run the command (or do the equivalent on Windows), e.g.

```
$ ssh -f -N -L 11111:nXXX:12345 user_name@login1.hoffman2.idre.ucla.edu  # on local computer
```

(Enter your Hoffman2 cluster password if needed. There will be no output if succeeded; this is normal.)

Adjust the port number accordingly. For example, if the actual port used on
the compute node is `12348` instead, the command above would be:
`ssh -f -N -L 11111:nXXX:12348 ...`. See also "Additional Information" below.

Now point your web browser at: `http://localhost:11111`

When prompted, enter token string from above, e.g. `dee346608015366d1be7f2dd69743e83cc3578e34476c2cd`.


## Step 4

At this point, if you can see your Hoffman2 directory listing in the notebook,
it means the notebook has been successfully connected to your local web browser.

Now enjoy Jupyter notebook computing!

## Step 5 (After your are done)

1. Kill the job (e.g. `qdel job_id` where "job_id" is the job number) if it is still running on Hoffman2 cluster.
2. Terminate the "ssh" processes on your local computer.


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