# Starting up: startdocker
In this directory we have a number of bash files for the testing phase
Typically with *startdocker* the directory structure is created in a directory 'docker'
and the right directories are copied or repositories checked out.
There are two options for that: local or remote.

With the option local we are assuming the repositories have been checked out
in a Windows environment and are connected to your virtual box by means of shared folders.
All shared folders are nicknamed win_<real name>.

The other option (remote) does not presuppose that the files are present. It assumes git
is installed and checks out the necessary repositories directly in the directory 'docker'.

Create a **docker** directory somewhere and move the startdocker script to that 
directory and optionally convert it to unix format:
`dos2unix startbox.sh`

Run the script the first time like this:
`sh ./startbox.sh

# Second step: box_start
After the *startdocker* script one can call the *box_start.sh* to startup the box. 
There are various options to cleanup (or keep) the previous state of the installation. 
Type the option -h to see what the usage of the *box_start* is.

When starting up the Learning toolbox from a Windows environment and running virtual box,
one can run *win_start* to do the necessary dos2unix conversions or alternatively, pass on the -d option
to the *box_start* script. In the *startbox* script we have made sure the necessary
dos2unix conversions have been made, so no win_start is necessary then.
The parameters of win_start or startbox will be passed on to box_start automatically 
to have it all in one go.

## Cleaning up previous attempts
The *clear.sh* script removes generated files and directories from the docker-compose 
process. It is called in the box_start script when passing the option 

The *addbox* is a script to add more layers on the fly. No check is done on preconditions
for a layer to run smoothly. Make sure to specify both the repository name and (separated by
a # sign) the tagged version. So: sh addbox ltb#0.6