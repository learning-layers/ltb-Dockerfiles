In this directory we have a number of bash files for the testing phase
Typically with <i>startdocker</i> the directory structure is created in a directory docker
and the right directories are copied or repositories checked out.
There are two options for that: local (assuming the repositories have been checked out
in a Windows environment and are connected to your virtual box by means of shared folders.
All shared folders are nicknamed win_<real name>.
The other option is remote and does not presuppose that the files are present. It assumes git
is installed and checks out the necessary directories.

After the <i>startdocker</i> script one can call the box_start.sh to startup the box. There are various options
to cleanup (or keep) the previous state of the installation. Type the option -h to see
what the usage of the <i>box_start</i> is.

When starting up the Learning toolbox from a Windows environment and running virtual box,
one can run <i>win_start</i> to do the necessary dos2unix conversions or alternatively, pass on the -d option
to the <i>box_start</i> script. The parameters of win_start will be passed on to box_start
automatically to have it all in one go.

The <i>clear.sh</i> script removes generated files and directories from the docker-compose 
process.
The <i>addbox</i> is a script to add more layers on the fly. No check is done on preconditions
for a layer to run smoothly. Make sure to specify both the repository name and (separated by
a # sign) the tagged version. So: sh addbox ltb#0.6