# ltb-Dockerfiles
The Dockerfiles for the Learning Toolbox.

To test and start up the Layersbox (including the Learning Toolbox) you can copy the
files under scripts and run startbox which will create the right directory structure and after
you can run box_start.sh (or if you are on windows win_start.sh).

So Assuming you have a Linux (virtual box) running checkout these files and the layersbox project
in your unix directory (say 'docker').
Then:
cd docker
cp scripts/* .
sh startbox.sh <local|remote>
Now, depending on whether you extract everything from github (option remote) or that 
you take files from local mounted directories (option local), files will be linked/copied or 
retrieved from Github to result in the structure
docker/layersbox
docker/ltb-Dockerfiles
