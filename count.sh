#!/bin/bash

set -e
set -u
set -o pipefail

#run cellranger count for all fastq files in data directory

#function to display a usage message in case of incorrect user input
usage()
{
    echo "Script usage: $(basename $0) [-p projectname] [-r path/to/referencegenome] [-f path/to/fastqfiledirectory] [-c path/to/countoutputdirectory]}" >&2
    exit 1
}

#make sure the reference directory is in a different directory than
#the directories containing the fastqs

#no_args is later used in case the user calls the script without 
#providing any options, as this is not handled by getopts
no_args=true

#argument parsing
while getopts 'p:r:f:c:' OPTION
	do
	    case "${OPTION}" in
	        p) 
				project=${OPTARG} #do i even need this? 
				;;	
	        r) 
				ref=${OPTARG} #absolute path
				;;
	        f) 
				fastqdir=${OPTARG} #absolute path
				;; 
	        c) 
				countdir=${OPTARG}
				;;
			?)
				usage
				;;
	                       
	    esac
	    #no_args only gets set to false if at least one option, even an
		#incorrect one, has been provided
		no_args=false
	done
	
if $no_args; then
	echo "Error: No options given."
	usage
fi	

echo "Project name: $project";
echo "Reference directory: $ref";
echo "Input data (fastq) directory: $fastqdir";
echo "Output directory (results of cellranger count): $countdir";
	

source activate __cellranger@3.1.0
	
#cellranger puts outputs into the current working directory
#so we change into the designated output directory
cd $countdir
	
#do cellranger count for every subdirectory (=individual samples) in fastqdir
#every subdirectory in fastqdir should only contain the fastqs for
#that sample library
	
for dir in ${inputdata}*/; do
	#extract the directory name and save as variable id
	#for naming purposes
	id=$dir
	id=$(dirname $dir)
	id=$(basename $dir)
		
	#run cellranger count
	#--id: name of output directory (here: same name as input directory containing fastqs)
	#--transcriptome: path to reference genome
	#--fastqs: path to fastqs of sample library
	cellranger count --id=$id --transcriptome=$ref --fastqs=$dir
done
	
	
		
