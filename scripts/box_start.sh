#!/bin/bash -x

#The -x is for debugging
function showHelp(){
    echo " Usage: sh box_start.sh [-h][-cleanoptions{dlpci}] where 
        -d = dos2unix all files (default 0) -d implies -n
        -l = get newest layersbox toolkit (default 0),
        -n = get newest scripts from the ltb-Dockerfiles (default 0).
        -p = run a python setup (default 0),
        -c 1 = cleanup containers (default 1), (-c 0 for keeping 
		the old containers)
        -i = cleanup images (default 0)
        -s = cleanup directory and run init and start also (default=1, -s 0 for adding
        layers only. Note that -s does not imply -c 1 or -i)
        -h = echo help "
        exit 1
}

layersboxfiles="https://github.com/learning-layers/LayersBox.git"
ltbdockerfiles="https://github.com/learning-layers/ltb-Dockerfiles.git"
do_dos2unix=0;
get_layersbox=0;
python_setup=0;
image_clean=0;
container_clean=1;
startup_clean=1
new_scripts=0;
if [ "$#" -gt 0 ]; then
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in        
        -s)
            startup_clean="$2"
            shift
        ;;
        -l)
            get_layersbox=1
        ;;
        -p)
            python_setup=1
        ;;
        -d)
            do_dos2unix=1
            new_scripts=1
        ;;
        -n) 
            new_scripts=1
        ;;
        -c)
            container_clean="$2"
            shift
        ;;
        -i)
            image_clean=1
        ;;
        -h)
            showHelp;
        ;;
        *)
            # unknown option
            showHelp
        ;;
    esac
    shift
  done
fi

#If we accidently throw away the layersbox directory, we are forced to start over
#from scratch
if [ ! -d ./layersbox ]; then
    startup_clean=1
fi

if [ "$startup_clean" = "1" ]; then
    if [ ! -d ./layersbox ] || [ "$get_layersbox" = "1" ]; then
        echo "Docker files are not there yet or refresh of files requested";
        rm -rf layersbox;
        git clone $layersboxfiles layersbox;

        echo "Done with getting the Layersbox Docker files";
        new_layersbox_scripts=1;
    else
        echo "Layersbox files are already there, clear old runs";
        new_layersbox_scripts=0;
        sh ./clear.sh
    fi &&

    #Here we dos2unix the scripts as far this is requested or needed
    if [ "$do_dos2unix" = "1" ] || [ "$new_scripts" = "1" ]; then
        if [ ! -d ../ltb-Dockerfiles ]; then
            git clone $ltbdockerfiles ../ltb-Dockerfiles
        fi
        cp -r ../ltb-Dockerfiles .
        
        echo "Converting scripts to unix format";

        find ./ltb-Dockerfiles/scripts -type f -exec dos2unix {} \;
        if [ "$do_dos2unix" = "1" ] || [ "$new_layersbox_scripts" = "1" ]; then
            find ./layersbox -type f -exec dos2unix {} \;
        fi
        echo "Conversion to Unix file format completed for Unix scripts (and layersbox).";
        echo "Copying scripts now. You have to type sh $0 without -d or -n"
        cp ./ltb-Dockerfiles/scripts/* .
        #Overwritten will be also current script, so exit here
        exit 0;
    fi 

    cd layersbox

    if [ "$python_setup" = "1" ] || [ "$new_layersbox_scripts" = "1" ]; then
        python setup.py install --user
    fi &&

    if [ "$new_layersbox_scripts" = "1" ]; then
        echo "Making layersbox script executable";
        chmod +x layersbox #this is the Python executable
    fi
fi

if [ "$container_clean" = "1" ]; then
    echo "Stopping old containers";
    docker ps -a -q | xargs -r docker stop
    //Used to be (but that fails when there are no containers) docker stop $(docker ps -a -q);
    echo "If there were no containers, nothing is done";
else
    echo "Keeping old containers";
fi &&

if [ "$image_clean" = "1" ]; then
    echo "Cleaning old images";
    docker images -q | xargs -r docker rmi
    //docker rmi $(docker images -q);
    //Used to be (but that fails when there are no images) docker rmi $(docker images -q);
    echo "Done cleaning old images (If there were no images, nothing is done)";
else
    echo "Keeping old images";
fi &&

if [ "$startup_clean" = "1" ]; then
    echo "Done: starting now basic layersbox"
    p=`pwd`
    echo "We are now in $p"
    echo "Go to layersbbox dir if you are not there yet and type:
    layersbox init
    layersbox start
    After: 
     layersbox install learning-layers/openldap#0.0.9 for released version 0.0.9
     layersbox install learning-layers/openidconnect#0.0.13 for released version 0.0.13
     layersbox install learning-layers/openldapaccount#0.0.7 for released version 0.0.7
     layersbox install learning-layers/socialsemanticserver#v11.9.6-alpha
     layersbox install learning-layers/ltb
     cd /home/ltb
    We will do the first two steps for you
    ";
    read -p "Type here your ip address:" SELF_URL
    printf "$SELF_URL\n" | ./layersbox init 
    ./layersbox start
fi

go_on='y'
while [ "$go_on" = "y" ]; do
    echo "Do you want to install new/more services? relevant might be openldap,openidconnect, openldapaccount,socialsemanticserver, ltb y/n"
    read go_on
    echo "You wanted to stop or not $go_on"
    if [ "$go_on" = "y" ]; then
        echo "What is the repo + version? type e.g. openldap#0.0.9?"
        read repo

        layersbox install learning-layers/$repo
        echo "Finished installing $repo"
    fi
done
echo "We are done now"