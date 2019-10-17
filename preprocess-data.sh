data_dir=$1
data=$2
input="${data_dir}/${data}"
for SPLIT in train val; do \
    python -m examples.roberta.multiprocessing_bpe_encoder \
        --encoder-json gpt2_bpe/encoder.json \
        --vocab-bpe gpt2_bpe/vocab.bpe \
        --inputs ${input}_${SPLIT}.txt \
        --outputs ${input}_${SPLIT}.bpe \
        --keep-empty \
        --workers 60; \
done
