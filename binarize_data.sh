#!/bin/bash
data_dir=$1
data=$2
fairseq-preprocess \
    --only-source \
    --srcdict gpt2_bpe/dict.txt \
    --trainpref ${data_dir}/${data}_train.bpe \
    --validpref ${data_dir}/${data}_val.bpe \
    --destdir ${data_dir} \
    --workers 60
