'''
A Snakefile for running `shigatyper` and parsing the output for LIMS/MDDI 
'''


import pandas as pd
import numpy as np
import glob, os, sys, pathlib


# def spread_isolates( tab_file_name ):
#     os.mkdir( "isolates" )
#     with open( tab_file_name, 'r' ) as tab_file:
#         for line in tab_file:
#             line_list = line.strip().split('\t')
#             with open( "isolates/" + line_list[0] + ".txt", 'w' ) as isolate_file:
#                 isolate_file.write( '\t'.join( line_list ))
#                 isolate_file.close()
#     tab_file.close()

def spread_isolates( tab_file_name ):
    isolate_path = pathlib.Path('isolates')
    if not isolate_path.exists():
        isolate_path.mkdir()
    tab = pathlib.Path(tab_file_name)
    tab_file = open(tab).readlines()
    for line in tab_file:
        line_list = line.strip().split('\t')
        isolate_file = isolate_path / f"{line_list[0]}.txt"
        isolate_file.write_text(line)

samples = [ line.strip() for line in open( pathlib.Path( "sample_names.list" )).readlines() ] 

sample_dupes = [x for n, x in enumerate( samples ) if x in samples[:n]]

##### RULES:

rule all:
    input:
        expand( 'isolates/{sample}.st', sample = samples ),
        "shigatypes.xlsx"

#####

rule prepare_input:
    input:
        "input.tab"
    output:
        expand( 'isolates/{sample}.txt', sample = samples )
    run:
        spread_isolates( "input.tab" )

#####

rule shiga_type:
    input:
        expand( 'isolates/{sample}.txt', sample = samples ) 
    output:
        expand( 'isolates/{sample}.st', sample = samples )
    shell:
        """
        singularity exec singularity/shigatyper.sif shigatyper -n $( cat {input} ) > {output}
        """

#####

rule combine_output:
    input:
        expand( 'isolates/{sample}.st', sample = samples )
    output:
        "isolates/output.txt"
    shell:
        """
        tail -1 {input} >> {output}
        """

        # echo "sample\tprediction\tipaB" > {output}

#####

rule parse_output:
    input:
        "isolates/output.txt"
    output:
        "shigatypes.xlsx"
    shell:
        """
        python3 parse_shigatype.py
        """

