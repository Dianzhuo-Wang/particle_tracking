#!/bin/bash

#SBATCH -t 0-12:00:00
#SBATCH -p short
#SBATCH --mem=100G

/n/app/matlab/2017a/bin/matlab -nodesktop -nosplash -r "run microrheology_analyze_1.m; exit;" >& log.txt
