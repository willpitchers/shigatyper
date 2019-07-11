#! /Users/williamp/anaconda3/bin/python

import pandas as pd
import numpy as np
import glob, os, sys, pathlib

# this bit checks for duplicate isolates in the <input.tab> file :
samples = [ line.strip() for line in open( pathlib.Path( "sample_names.list" )).readlines() ] 

sample_dupes = [x for n, x in enumerate( samples ) if x in samples[:n]]

if len( sample_dupes ) > 0:
    # print( "duplicate samples" )
    sys.exit( 1 )
else:
    sys.exit( 0 )


# other input-hygiene may appear here in future...