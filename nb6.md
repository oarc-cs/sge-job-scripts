# Running Jupyter Notebook on the compute node

The job script `nb6.sh` enables you to launch a jupyter notebook on the
CentOS 6 compute node that can be connected your local computer's browser
using ssh port forwarding via Hoffman2 cluster's login node (login1 in 
the following example). While the script itself is short, additional commands
need to be issued, as instructed below.

## Step 1

Modify the job script, such as the run time `h_rt`, memory size `h_data`, the
`module load` (to load all othe modules your jupyter notebook will need at 
runtime) to your liking. Then submit this job by the command:

```
$ qsub nb6.sh
```

Wait for the job to start.

## Step 2

After the job is started (on compute node nXXXX), i.e. in "r" state as shown by

```
$ qstat -u $USER
```

issue this command on the login node to find out the actual port and token
the notebook is using:

```
$ ssh nXXXX jupyter notebook list
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

On your local computer, run the command (or the equivalent on Windows), e.g.

```
$ ssh -f -N -L 12345:nXXX:12345 user_name@login1.hoffman2.idre.ucla.edu
```

(adjust the port number accordingly. See also "Additional Information" below.)

Now point your web browser at: `http://localhost:12345`

When prompted, enter token sting from above, e.g. `dee346608015366d1be7f2dd69743e83cc3578e34476c2cd`.


## Step 4

If you can see the directory listing after entering the token from Step 3, then
the notebook has been successfully connected to your local web browser.

Enjoy jupyter notebook computing!

## Step 5 (After your are done)

1. Kill the job (qdel $job_id) if it is still running on Hoffman2 cluster.
2. Terminate the "ssh" processes on your local computer.


## Additional information:

In the port forwarding command syntax, `ssh -f -N -L PPPP:nXXX:QQQQ ...`,
the first number PPPP is your local computer's port, and the second number QQQQ is
the port number of Hoffman2's compute node running Jupyter notebook (as shown
by the "jupyter notebook list" command above). In case your local port is not
available, you can simply try a new port number, e.g. changing it to 12348:

```
 $ ssh -f -N -L 12348:nXXX:12345
```

In this case, `12348` is your local port number, so point your browser to `http://localhost:12348` to connect to the notebook.