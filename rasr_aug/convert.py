import sox 
import os 
from multiprocessing import Pool
dirs = [
    # "balanced_train_segments",
    "unbalanced_train_segments",
    # "eval_segments"
]

def process(inp):
    i, o = inp 
    os.system(f"sox {i} -b 16 -c 1 -r 16000 {o}")


for d in dirs:
    bp = f"/datasets01/audioset/042319/data/{d}/audio"
    op = f"/checkpoint/vineelkpratap/data/audioset/{d}"
    os.system(f"mkdir -p {op}")
    lst = []
    for f in os.listdir(bp):
        iff = f"{bp}/{f}"
        off = f"{op}/c{f}"
        lst.append((iff, off))
    p = Pool(80)
    p.map(process, lst)
    print(d)

