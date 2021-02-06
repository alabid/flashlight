import os 
import sys 
split = sys.argv[1]

indir = f"/tmp/chime/{split}"
outdir = f"/checkpoint/vineelkpratap/data/chime5"

os.system(f"mkdir -p {outdir}/{split}")

sx_cmds = {}
with open(f"{indir}/wav.scp") as f:
    for line in f:
        spl = line.split()
        sx_cmds[spl[0]] = spl[2]

tstamps = {}
with open(f"{indir}/segments") as f:
    for line in f:
        spl = line.strip().split()
        tstamps[spl[0]] = spl[1:]
exec_parallel = []
with open(f"{outdir}/{split}.lst", 'w') as fo:     
    with open(f"{indir}/text") as f:        
        for line in f:
            hndl, text = line.strip().split(' ', 1) 
            af, st, en = tstamps[hndl] 
            af = sx_cmds[af]
            st = float(st)
            en = float(en)
            dr = en - st
            drs = dr 
            ch = 1 if hndl.endswith('L') else 2
            oaf = f"{outdir}/{split}/{hndl}.flac"
            exec_parallel.append(f"sox {af} {oaf}  remix {ch} trim {st} {dr}")
            fo.write(f"{hndl} {oaf} {drs} {text}\n")

def process(cmd):
    os.system(cmd) 
from multiprocessing import Pool 
p = Pool(80)
p.map(process, exec_parallel)
p.close()
