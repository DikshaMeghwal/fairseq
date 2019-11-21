import csv

csv.field_size_limit(2147483647)
task = input()
no_samples = int(input())
with open(f'glue_data/{task}/train_org.tsv', 'r', newline='') as readFile:
    reader = csv.reader(readFile)
    lines = list(reader)

lines = lines[:no_samples]
# print(lines[0])

with open(f'glue_data/{task}/train_shrink.tsv', 'w', newline='') as writeFile:
    writer = csv.writer(writeFile)
    for line in lines:
        print(f"writing line:{line}")
        writer.writerow(line)
readFile.close()
writeFile.close()
