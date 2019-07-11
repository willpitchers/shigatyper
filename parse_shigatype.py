#! /Users/williamp/anaconda3/bin/python

import pandas as pd
import numpy as np
import glob, os, sys, pathlib

## This script should read in a concatenated output file (from isolates/) and return a file in a MDDI-appropriate format

# output dictionary from shigatyper.py for reference
SfDic = {"Shigella flexneri Yv": ["Xv"],
         "Shigella flexneri serotype 1a": ["gtrI"],
         "Shigella flexneri serotype 1b": ["gtrI", "Oac1b"],
         "Shigella flexneri serotype 2a": ["gtrII"],
         "Shigella flexneri serotype 2b": ["gtrII", "gtrX"],
         "Shigella flexneri serotype 3a": ["gtrX", "Oac"],
         "Shigella flexneri serotype 3b": ["Oac"],
         "Shigella flexneri serotype 4a": ["gtrIV"],
         "Shigella flexneri serotype 4av": ["gtrIV", "Xv"],
         "Shigella flexneri serotype 4b": ["gtrIV", "Oac"],
         "Shigella flexneri serotype 5a": (["gtrV", "Oac"], ['gtrV']),
         "Shigella flexneri serotype 5b": (["gtrV", "gtrX", "Oac"], ['gtrV', 'gtrX']),
         "Shigella flexneri serotype X": ["gtrX"],
         "Shigella flexneri serotype Xv (4c)": ["gtrX", "Xv"],
         "Shigella flexneri serotype 1c (7a)": ['gtrI', 'gtrIC'],
         "Shigella flexneri serotype 7b": ['gtrI', "gtrIC", "Oac1b"]}

# echo "sample\tprediction\tipaB" > {output}


shigatype_dataframe = pd.read_csv( "isolates/output.txt", sep="\t", header=None )

pd.DataFrame.to_excel( "shigatypes.xlsx" )

# "Not Shigella or EIEC"
# "Shigella boydii serotype 13"
# "Not Shigella or EIEC"
# "Shigella sonnei form II"
# "Shigella sonnei (low levels of form I)"
# "Shigella sonnei, form I"
# "EIEC"
# "Shigella dysenteriae serotype 1"
# "Shigalla dysenteriae serotype 1, rfp- (phenotypically negative)"
# "Shigella dysenteriae serotype 8"
# "Shigella boydii serotype 11"
# "Shigella boydii serotype 6 or 10"
# "Shigella boydii serotype 10"
# "Shigella boydii serotype 6"
# "Shigella boydii serotype 20"
# "Shigella boydii serotype 1"
# "Shigella boydii Provisional serotype E1621-54"
# "Shigella dysenteriae Provisional serotype 96-265"
# "Shigella dysenteriae Provisional serotype E670-74"
# "Shigella flexneri serotype 6"
# "Shigella flexneri serotype Y"
# "Shigella flexneri, novel serotype"

