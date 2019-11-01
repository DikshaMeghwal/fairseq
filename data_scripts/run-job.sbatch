#!/bin/bash

#SBATCH --job-name=token-newscomm
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30GB
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=dm4511@nyu.edu

. ~/.bashrc

conda activate vision

python tokenizer.py $1 
