#!/bin/bash -x

#The -x is for debugging
function showHelp(){
    echo " Usage: sh box_start.sh [-h][-cleanoptions{dlpci}] where 
	-d = dos2unix all files (default false) 
        -l = get newest layersbox toolkit (default false),
        -p = run a python setup (default false),
        -c 1 = cleanup containers (default true), (-c 0 for keeping 
		the old containers)
        -i = cleanup images (default false)
        -h = echo help "
        exit 1
}

dockerfiles="https://github.com/learning-layers/LayersBox.git"
do_dos2unix=0;
get_layersbox=0;
python_setup=0;
image_clean=0;
container_clean=1;
if [ "$#" -gt 0 ]; then
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
        -l)
            get_layersbox=1
        ;;
        -p)
            python_setup=1
        ;;
        -c)
            container_clean="$2"
            shift
        ;;
        -i)
            image_clean=1
        ;;
        -d)
            do_dos2unix=1
        ;;	
        -h)
            showHelp;
        ;;
        *)
            # unknown option
        ;;
    esac
    shift
  done
fi

if [ ! -d ./layersbox ] || [ "$get_layersbox" = "1" ]; then
    echo "Docker files are not there yet or refresh of files requested";
    rm -rf layersbox;
    git clone $dockerfiles ./layersbox;
    echo "Done with getting the Layersbox Docker files";
    new_layersbox_scripts=1;
else
    echo "Docker files are already there, clear old config";
    new_layersbox_scripts=0;
    sh ./clear.sh
   
fi &&

#Here we dos2unix the scripts as far this is requested
if [ "$do_dos2unix" = "1" ]; then
	echo "Converting scripts to unix format";
	
	find ./ltb-Dockerfiles -type f -exec dos2unix {} \;
	find ./layersbox -type f -exec dos2unix {} \;
	# dos2unix ./box_start.sh; # Already done if you are here
	# dos2unix ./box_start2.sh;
	# dos2unix ./ltb_api_start.sh; # Only used in old Docker process
	# dos2unix ./ltb_ts_start.sh; # Only used in old Docker process
	dos2unix ./terminal_open.sh;
    dos2unix ./clear.sh;
    dos2unix ./addbox.sh;
	echo "Conversion to Unix file format completed for Unix scripts. Starting up docker process..."; sleep 6;
fi

cd layersbox

if [ "$python_setup" = "1" ] || [ "$new_layersbox_scripts" = "1" ]; then
    python setup.py install --user
fi &&

if [ "$container_clean" = "1" ]; then
    echo "Stopping old containers";
    docker stop $(docker ps -a -q)
    echo "Cleaning old containers";
    docker rm $(docker ps -a -q);
else
    echo "Keeping old containers";
fi &&

if [ "$image_clean" = "1" ]; then
    echo "Cleaning old images";
    docker rmi $(docker images -q);
    echo "Done cleaning old images";
else
    echo "Keeping old images";
fi &&


if [ "$new_layersbox_scripts" = "0" ]; then
    echo "Making layersbox script executable";
    chmod +x layersbox #this is the Python executable
fi
echo "Done: starting now basic layersbox"
p=`pwd`
echo "We are now in $p"
echo "Go to layersbbox dir if you are not there yet and type:
layersbox init
layersbox start
After: 
# layersbox install learning-layers/openldap#0.0.5 for released version 0.0.5
# layersbox install learning-layers/openldapaccount#0.0.5 for released version 0.0.5
# layersbox install learning-layers/oidcclient#0.0.5 for released version 0.0.5
# layersbox install learning-layers/sss
# layersbox install learning-layers/ltb
# cd /home/ltb
We will do the first two steps for you
";
read -p "Type here your ip address" SELF_URL
printf "$SELF_URL\n" | ./layersbox init 
./layersbox start

go_on='y'
while [ "$go_on" = "y" ]
do
echo "Do you want to install more services? relevant might be openldap,oidcclient, sss, ltb y/n"
read go_on
echo "You wanted to stop or not $go_on"
if [ "$go_on" = "y" ]; then
	echo "What is the repo + version? type e.g. openldap#0.0.7?"
	read repo
    
	layersbox install learning-layers/$repo
	echo "Finished installing $repo"
fi
done
echo "We are done now"
# layersbox install learning-layers/openldap#0.0.5 for released version 0.0.5
# layersbox install learning-layers/openldapaccount#0.0.5 for released version 0.0.5
# layersbox install learning-layers/oidcclient#0.0.5 for released version 0.0.5
# layersbox install learning-layers/sss
# layersbox install learning-layers/ltb
# cd /home/ltb
# echo "Finished starting up the LearningToolbox"
# if [ -f ./ltb_deploy.txt ]; then 
  #   cat ltb_deploy.txt
    # sh terminal_open.sh
#else 
 #   echo "The LearningToolbox Layer has failed";
#fi
