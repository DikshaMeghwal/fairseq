#!/bin/bash
#SBATCH --job-name=fine-BERT
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=50GB
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=dm4511@nyu.edu

TOTAL_NUM_UPDATES=123873  # 10 epochs through RTE for bsz 16
WARMUP_UPDATES=7432       # 6 percent of the number of updates
LR=1e-05                  # Peak LR for polynomial LR scheduler.
NUM_CLASSES=3
MAX_SENTENCES=32          # Batch size.
ROBERTA_PATH=$1
SAVE_DIR=$2
DATA_DIR=$3

CUDA_VISIBLE_DEVICES=0 python train.py $DATA_DIR \
    --restore-file $ROBERTA_PATH \
    --max-positions 512 \
    --max-sentences $MAX_SENTENCES \
    --max-tokens 4400 \
    --task sentence_prediction \
    --reset-optimizer --reset-dataloader --reset-meters \
    --required-batch-size-multiple 1 \
    --init-token 0 --separator-token 2 \
    --arch roberta_base \
    --criterion sentence_prediction \
    --num-classes $NUM_CLASSES \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.1 --optimizer adam --adam-betas "(0.9, 0.98)" --adam-eps 1e-06 \
    --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $LR --total-num-update $TOTAL_NUM_UPDATES --warmup-updates $WARMUP_UPDATES \
    --fp16 --fp16-init-scale 4 --threshold-loss-scale 1 --fp16-scale-window 128 \
    --max-epoch 10 \
    --find-unused-parameters \
    --best-checkpoint-metric accuracy --maximize-best-checkpoint-metric \
    --save-dir $SAVE_DIR;
