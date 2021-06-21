#!/bin/bash

set -e
set -u
set -o pipefail

#convert bam files to fastq files with cellranger

#function to display a usage message in case of incorrect user input
usage()
{
    echo "Script usage: $(basename $0) [-p projectname] [-b path/to/bamfiledirectory] [-f path/to/fastqfiledirectory]" >&2
    exit 1
}

#no_args is later used in case the user calls the script without 
#providing any options, as this is not handled by getopts
no_args=true

#argument parsing
while getopts 'p:b:f:' OPTION
	do
	    case "${OPTION}" in
	        p) 
				project=${OPTARG}
				;;
	        b) 
				bamdir=${OPTARG}
				;;
	        f) 
				fastqdir=${OPTARG}
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
	echo "Error: No options given."
	usage
fi	

echo "Project name: $project";
echo "BAM file directory: $bamdir";
echo "Fastq file directory: $outputdir";
		

#take each file in directory containing bam files
#and convert them to fastq using bamtofastq
#save fastq files in fastq directory
for filename in $bamdir/*.bam; do
	fastqsubdir=$(basename "${filename%.*}")
	echo $fastqsubdir
	echo $fastqdir
	
	bamtofastq $filename $fastqdir/$fastqsubdir
	####bamtofastq $filename $dir
done

