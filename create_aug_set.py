import json 
import sys 
import random 
import os
from multiprocessing import Pool

snrr = [0, 40]

lst_file = "/checkpoint/jacobkahn/data/lists/librispeech/dev-clean.lst"
tag = sys.argv[1]
out_dir = f"/checkpoint/vineelkpratap/data/augmented/{tag}"

base_config =  """{
      "soundEffectChain": [
          {
              "type": "AdditiveNoise",
              "additiveNoiseConfig": {
                  "proba": 0.5,
                  "ratio": 1.0,
                  "minSnr": [snr],
                  "maxSnr": [snr],
                  "nClipsMin": 1,
                  "nClipsMax": 2,
                  "listFilePath": "/checkpoint/vineelkpratap/data/audioset/eval_segments.lst"
              }
          }
      ]
  }
"""

random.seed(0)
binary = "/private/home/vineelkpratap/flashlight/build/fl_asr_sfx_apply"
os.system(f"mkdir -p {out_dir}")
os.system(f"mkdir -p {out_dir}/audio")

def process(inp):
    idx, line = inp
    a, b, c, d = line.strip().split(" ", 3)
    snr = snrr[0] + random.random() * (snrr[1] - snrr[0]) 
    cfg = f"{out_dir}/audio/{idx}.sfx"
    b1 = f"{out_dir}/audio/{idx}.flac"
    with open(cfg, 'w') as fo:
        fo.write(base_config.replace("[snr]", str(snr)))
    cmd = f"{binary} --input={b} --output={b1} --config {cfg}"
    ++idx
    os.system(cmd)
            
    return (a + "\t" + b1 + "\t" + c + "\t" + d)      

inps = []
with open(lst_file) as f:
    with open(lst_file) as f:
        lines = f.readlines()
idx = 0
for line in lines:
    inps.append((idx, line))
    idx = idx + 1

p = Pool(80)
outs = p.map(process, inps)

with open(f"{out_dir}/augmented.lst", "w") as foo:
    for o in outs:
        foo.write(o + "\n")
