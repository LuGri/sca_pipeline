#!/bin/bash

#from https://linuxconfig.org/how-to-use-getopts-to-parse-a-script-options

#The provided shell options at the beginning of the scripts are not 
#mandatory, but it's a good habit to use them in every script we write. 
#In brief, -e, short for errexitmodifies the behavior of the shell that 
#will exit whenever a command exits with a non zero status (with 
#some exceptions). -u is another very important option: this makes the
#shell to treat undefined variables as errors.

#Finally the pipefail changes the way commands inside a pipe are
#evaluated. The exit status of a pipe will be that of the rightmost 
#command to exit with a non zero status, or zero if the all the programs
#in the pipe are executed successfully. In other words, the pipe will be
#considered successful if all the commands involved are executed 
#without errors.

set -e
set -u
set -o pipefail


#function to display a usage message in case of incorrect user input
usage()
{
    echo "Script usage: $(basename $0) [-c path/to/configfile]" >&2
    exit 1
}

#no_args is later used in case the user calls the script without 
#providing any options, as this is not handled by getopts
no_args=true

#option parsing
while getopts 'c:' OPTION; do
	case "${OPTION}" in
		c)
			CONFIG="$OPTARG"
			echo "The config file provided is $OPTARG"
			;;
		?)
			usage			
			;;
	esac
	#no_args only gets set to false if at least one option, even an
	#incorrect one, has been provided
	no_args=false
done			

#Display usage message and exit if no arguments have been provided
if $no_args; then
	echo "Error: No options given. Please provide a config file."
	usage
fi

#load config file containing variables used further					
source $CONFIG

#main
#run selected modules

if $download; then
    echo 'Running download.sh'
    #TODO
fi

if $bamtofastq; then
	echo "Running bamtofastq.sh"
	#TODO
fi

if $count; then
    echo 'Running count.sh'
    #TODO
fi

if $aggr; then
    echo 'Running aggr.sh'
    #TODO
fi
