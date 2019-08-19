#!/bin/bash
# Example with 28 cores for OpenMP
#
# Project/Account
#SBATCH -A hpc2n-1234-56
#
# Number of cores
#SBATCH -c 28
#
# Runtime of this jobs is less then 12 hours.
#SBATCH --time=12:00:00
#

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1

# Load the module environment suitable for the job
module load foss/2019a
​
# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

./omp_hello
# End of submit file