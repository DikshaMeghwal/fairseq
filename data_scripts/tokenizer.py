from mosestokenizer import *
import argparse
from collections import Counter

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('filename', metavar='N', type=str,
                    help='file containing raw english text to be tokenized')
args = parser.parse_args()
file_name = args.filename
print(file_name)

tokenize = MosesTokenizer('en')
token_count = 0
vocab = Counter()

with open(file_name, 'r') as infile:
    for line in infile:
        data = line.replace('\n', '')
        new_tokens = tokenize(data)
        token_count += len(new_tokens)
        new_vocab = Counter(new_tokens)
        vocab += new_vocab
print(f"#tokens:{token_count}")
print(f"vocab size: {len(vocab)}")
