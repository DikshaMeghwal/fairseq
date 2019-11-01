#!/bin/bash
#SBATCH --job-name=pre-BERT
#SBATCH --nodes=1
#SBATCH --gres=gpu:2 -c2
#SBATCH --mem=50GB
#SBATCH --time=168:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=dm4511@nyu.edu

TOTAL_UPDATES=125000    # Total number of training steps
WARMUP_UPDATES=10000    # Warmup the learning rate over this many updates
PEAK_LR=0.0005          # Peak learning rate, adjust as needed
TOKENS_PER_SAMPLE=512   # Max sequence length
MAX_POSITIONS=512       # Num. positional embeddings (usually same as above)
MAX_SENTENCES=8         # Number of sequences per batch (batch size)
UPDATE_FREQ=64          # Increase the batch size 16x
DATA_DIR=$1
SAVE_DIR=$2
SAVE_INTERVAL=$3

python train.py --fp16 $DATA_DIR \
    --task masked_lm --criterion masked_lm \
    --arch roberta_base --sample-break-mode complete --tokens-per-sample $TOKENS_PER_SAMPLE \
    --optimizer adam --adam-betas '(0.9,0.98)' --adam-eps 1e-6 --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $PEAK_LR --warmup-updates $WARMUP_UPDATES --total-num-update $TOTAL_UPDATES \
    --dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
    --max-sentences $MAX_SENTENCES --update-freq $UPDATE_FREQ \
    --max-update $TOTAL_UPDATES --log-format simple --log-interval 1
