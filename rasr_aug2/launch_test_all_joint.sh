#!/bin/bash

#SBATCH --output=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/log/%j.out
#SBATCH --error=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/log/%j.err
#SBATCH --comment=w2l_eval
#SBATCH --job-name=rasr_eval
#SBATCH --partition=dev,learnfair
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:8
#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=7G
#SBATCH --open-mode=append
#SBATCH --time=3:00:00
#SBATCH -C volta32gb

module purge
module load cuda/10.0
module load cudnn/v7.6-cuda.10.0
module load NCCL/2.4.7-1-cuda.10.0
module load mkl/2018.0.128
module load gcc/7.3.0
module load cmake/3.15.3/gcc.7.3.0

srun sh /private/home/vineelkpratap/flashlight/rasr_aug2/test_all_joint.sh $@
