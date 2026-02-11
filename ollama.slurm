#!/bin/bash
#----------------------------------------------------

#SBATCH -J ollama          # Job name
#SBATCH -o ollama-out.%j       # Name of stdout output file
#SBATCH -e ollama0-err.%j       # Name of stderr error file
#SBATCH -p gh-dev          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 00:30:00        # Run time (hh:mm:ss)
#SBATCH -A TACC-SCI

set -o errexit -o pipefail

module unload xalt
module load tacc-apptainer
module list

cd $SCRATCH/ollama_test

# start the ollama service (this will download the image if it doesn't find it)
. ./start-ollama.sh

# make sure that the ollama service is up
./check-ollama-up.sh

# pull the needed model
uv run pull_model.py

sleep 2

# query the model
uv run count_to_50.py

sleep 5

# shut down the ollama instance
apptainer instance stop ollama-eriksf

# ---------------------------------------------------
