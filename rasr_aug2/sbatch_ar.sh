#!/bin/bash

#SBATCH --cpus-per-task=10
#SBATCH --partition=priority
#SBATCH --gres=gpu:volta:8
#SBATCH --constraint=volta32gb,bldg2
#SBATCH --ntasks-per-node=8
#SBATCH --nodes=8
#SBATCH --time=48:00:00
#SBATCH --mem=440GB
#SBATCH --signal=B:USR1@200
#SBATCH --comment=icassp
#SBATCH --open-mode=append
#SBATCH --job-name=memdbg
#SBATCH --output=/checkpoint/vineelkpratap/experiments/chai_bug_repro_af_mem/vineelkpratap-%j.out
#SBATCH --error=/checkpoint/vineelkpratap/experiments/chai_bug_repro_af_mem/vineelkpratap-%j.err

# 1. Load modules
module purge
module load cuda/11.0
module load cudnn/v8.0.3.33-cuda.11.0
module load NCCL/2.8.3-1-cuda.11.0
module load intel/mkl/2020.3.279
module load kenlm/010421/gcc.9.3.0

/usr/mpi/gcc/openmpi-4.0.4rc3/bin/mpirun /private/home/vineelkpratap/flashlight/build/flashlight/fl/test/AllReduceBenchmark
