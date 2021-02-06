#!/bin/bash

echo $1

fp=$1
base=$( echo ${fp%/*} )
last=$( echo ${fp##/*/} )
slast=$( echo ${base##/*/} )
logdir=test_all_${slast}_${last}_$2

mkdir -p /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir

samplerate=16
ch_list=hub05-callhome.${samplerate}khz.lst
sw_list=hub05-switchboard.${samplerate}khz.lst
rt03_list=rt03s_eval.${samplerate}KHz.lst

binary=/private/home/vineelkpratap/flashlight/build/bin/asr/fl_asr_test

# ls family
$binary --am=$1 --datadir=/checkpoint/jacobkahn/data/lists/librispeech --test=dev-clean.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/jacobkahn/data/lists/librispeech --test=test-clean.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/jacobkahn/data/lists/librispeech --test=dev-other.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/jacobkahn/data/lists/librispeech --test=test-other.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

# ls augmented

$binary --am=$1 --datadir=/checkpoint/vineelkpratap/data/augmented/ --test=ls_other_addnoise/augmented.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

$binary --am=$1 --datadir=/checkpoint/vineelkpratap/data/augmented/ --test=ls_clean_addnoise/augmented.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

# cv
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/ --test=commonvoice/lists/dev.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/ --test=commonvoice/lists/test.lst --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

# chime 6
$binary --am=$1 --datadir=/checkpoint/vineelkpratap/data/ --test=chime5/dev.lst.simple --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

# wsj
$binary --am=$1 --datadir=/checkpoint/antares/datasets/wsj/lists/ --test=nov93dev.lst.fixed --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite//$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/antares/datasets/wsj/lists/ --test=nov92.lst.fixed --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite//$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

# tl
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/tedlium/lists/ --test=dev.lst.fixed --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite//$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/tedlium/lists/ --test=test.lst.fixed --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite//$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

#swb
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/swbd_lists/noNL --test=$ch_list --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/wav2letter/data/swbd_lists/noNL --test=$sw_list --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''
$binary --am=$1 --datadir=/checkpoint/vineelkpratap/rt03s_eval/original/lists --test=$rt03_list --uselexicon=false --lm=     --sclite=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --nthread_decoder_am_forward=8  --tokens=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/letters.tokens --lexicon=/checkpoint/wav2letter/transfer_learning/tokens/common_voice/cv-train-dev-letters.lexicon --samplerate=16000   --surround= --wordseparator='|'  --tokens=/checkpoint/wav2letter/transfer_learning/aws/icassp_paper/ams/swb.tokens --emission_dir=''

cd /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir
awk '{print $NF,$0}' ../hub05-callhome.ref | sort | cut -f2- -d' ' > ${ch_list}.viterbi.ref
awk '{print $NF,$0}' ../hub05-switchboard.ref | sort | cut -f2- -d' ' > ${sw_list}.viterbi.ref
awk '{print $NF,$0}' ../rt03_list.ref | sort | cut -f2- -d' ' > ${rt03_list}.viterbi.ref

awk '{print $NF,$0}' ${ch_list}.hyp | sort | cut -f2- -d' ' > tmp
mv tmp ${ch_list}.hyp
awk '{print $NF,$0}' ${sw_list}.hyp | sort | cut -f2- -d' ' > tmp
mv tmp ${sw_list}.hyp
awk '{print $NF,$0}' ${rt03_list}.hyp | sort | cut -f2- -d' ' > tmp
mv tmp ${rt03_list}.hyp
rm tmp

python /private/home/qiantong/sclite/viterbi_hyp_ref_transformer.py --datadir=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --test=$ch_list
python /private/home/qiantong/sclite/viterbi_hyp_ref_transformer.py --datadir=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --test=$sw_list
python /private/home/qiantong/sclite/viterbi_hyp_ref_transformer.py --datadir=/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir --test=$rt03_list

/private/home/qiantong/sclite/sctk-2.4.10/bin/hubscr.pl \
	-p /private/home/qiantong/sclite/sctk-2.4.10/bin \
	-V -l english -h hub5 \
	-g /private/home/qiantong/sclite/en20000405_hub5.glm \
	-r /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${ch_list}.stm.ref \
	/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${ch_list}.ctm.hyp

/private/home/qiantong/sclite/sctk-2.4.10/bin/hubscr.pl \
	-p /private/home/qiantong/sclite/sctk-2.4.10/bin \
	-V -l english -h hub5 \
	-g /private/home/qiantong/sclite/en20000405_hub5.glm \
	-r /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${sw_list}.stm.ref \
	/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${sw_list}.ctm.hyp

/private/home/qiantong/sclite/sctk-2.4.10/bin/hubscr.pl \
	-p /private/home/qiantong/sclite/sctk-2.4.10/bin \
	-V -l english -h hub5 \
	-g /checkpoint/vineelkpratap/rt03s_eval/en20030506.glm \
	-r /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${rt03_list}.stm.ref \
	/checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/${rt03_list}.ctm.hyp

cat /checkpoint/vineelkpratap/wav2letter_experiments/eval_all/sclite/$log_dir/*.dtl | grep "Percent Total Error"
