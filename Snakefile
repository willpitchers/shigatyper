'''
A Snakefile for running `shigatyper` and parsing the output for LIMS/MDDI 
'''


import pandas as pd
import numpy as np



# def get_fastq(wildcards):
#     return {"r1": pathlib.Path(samples.loc[wildcards.sample,'R1']).absolute().as_posix(), "r2": pathlib.Path(samples.loc[wildcards.sample,'R2']).absolute().as_posix()}

def spread_isolates( tab_file_name ):
    with open( tab_file_name, 'r' ) as tab_file:
        for line in tab_file:
            line_list = line.strip().split('\t')
            with open( line_list[0]+".txt", 'w' ) as isolate_file:
                isolate_file.write( '\t'.join( line_list ))
                isolate_file.close()

rule all:
    input:
        "output.txt"
 

rule prepare_input:
    input:
        "input.tab"
    output:
        ""
    run: 


rule shigatype:
    input:
        "input.tab"
    output:
        "output.txt"
    shell:
        " cat input.tab > while read i ; do python3 shigatyper/shigatyper.py ${i} ; > output.txt"
    

# rule srst2_aggregate:
#     input:
#         expand("{sample}/{sample}__genes__EcOH__results.txt", sample=samples.index)
#     params:
#         prefix="ecoh_summary"
#     output:
#         "ecoh_summary__compiledResults.txt"
#     conda: config['srst2_config_file']
#     shell:
#         "aggregate_results.py {params.prefix} {input}"