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
MAX_SENTENCES=80         # Number of sequences per batch (batch size)
UPDATE_FREQ=64          # Increase the batch size 16x
ROBERTA_PATH="../checkpoints/checkpoint$1.pt"
DATA_DIR=$2

echo $ROBERTA_PATH, $DATA_DIR

fairseq-eval-lm --fp16 $DATA_DIR --path $ROBERTA_PATH \
    --task language_modeling \
    --sample-break-mode complete --tokens-per-sample $TOKENS_PER_SAMPLE \
    --max-sentences $MAX_SENTENCES \
    --add-bos-token \
    --log-format simple --log-interval 1 
