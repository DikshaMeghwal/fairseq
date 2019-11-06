data_dir=$1
file_prefix=$2
input="${data_dir}/${file_prefix}"
python -m examples.roberta.multiprocessing_bpe_encoder \
    --encoder-json gpt2_bpe/encoder.json \
    --vocab-bpe gpt2_bpe/vocab.bpe \
    --inputs ${input}_test \
    --outputs ${input}_test.bpe \
    --keep-empty \
    --workers 60;
