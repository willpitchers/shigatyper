#! /bin/bash

## This is the control file to drive the `shigella_typing` pipeline
## input is either an "input.tab" (Torstyverse-mdu-reads-style) file or a list of MDU-IDs


# fail politely if no input provided
if (($# == 0)); then
	echo Please provide MDU IDs or fastq read files.
  exit 1
fi


## requirements checker
check_reqs() {
	command -v python3 >/dev/null 2>&1 || { echo >&2 "I require python3 but it's not installed.  Aborting."; exit 1; }
	command -v snakemake >/dev/null 2>&1 || { echo >&2 "I require snakemake but it's not installed.  Aborting."; exit 1; }
	echo "Requirements met -- Good job!"
}

## input file checker
check_input() {
    num_dodgy_lines=$( grep -v  --color="always" -E '^[[:alnum:]_-]+\t[[:alnum:]/\._-]+\t[[:alnum:]/\._-]+$' input.tab -c )
    if [[ ! num_dodgy_lines -eq 0 ]] ; then
        echo "      Please check the format of your input file. It should be:"
        echo "      Isolate-ID<tab>/path/to/read_1_file.fastq<tab>/path/to/read_2_file.fastq"
    fi
}

## command line help
display_help() {
	echo "The What:"
	echo "	this tool assigns species and serotype ID to Illumina paired-end readsets for Shigella isolates"
    echo "The How:"
    echo "	bash shigella_typing.sh [-h] [-n SAMPLE_NAME read1 read2] <input_file.txt>"
    echo "			Input should be: Isolate-ID <tab> /path/to/read_1_file.fastq <tab> /path/to/read_2_file.fastq "
    echo "			(path can be skipped if using MDU IDs - see below)"
    echo "Options:"
    echo "   -h			show this help screen"
    echo "   -n			provide sample name followed by paths instead of an input file"
    echo "   -r			check that requirements are met"
    echo "   -v			verbose mode"
    echo
    exit 1
}


# parse non-zero input: help flag
while getopts ":hnrv" opt; do
  case $opt in
    h)
      display_help >&2
      ;;
    n)
      read_path="TRUE"
      ;;
    r)
     check_reqs >&2
     exit
      ;;
    v)
     verbose="TRUE"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


if (( read_path == "TRUE" )) ; then
    echo -e ${2}'\t'${3}'\t'${4} > input.tab
# else
#     cp ${2} input.tab
#     check_input_file
fi

cut -f 1 input.tab > sample_names.list


### Run the thing!

snakemake