


import os 
import sox 

from multiprocessing import Pool 



files = [
# "/private/home/qiantong/wav2letter_experiments/256_GPU/join_train_filtered_maxlen.25s.lst"
"/checkpoint/wav2letter/data/commonvoice/lists/dev.lst"
]

def process(i):
    c = sox.file_info.channels(i)
    assert c == 1 , i 

a = []
for f in files:
    print(f)
    with open(f) as fi:
        for line in fi:
            a.append(line.split()[1])

p = Pool(80)
p.map(process, a)
