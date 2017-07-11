# preprocess individual corpus = normalize-punctuation, lowercase, tokenize

src=en
trg=fr

#bpe_operations=20000

mosespath=/home/multimt/libs/external/mosesdecoder

scriptpath=$mosespath/scripts/tokenizer

subwordpath=/home/multimt/libs/external/subword-nmt

inputpath=/home/multimt/datasets/wmt17_mmt/task1

bpemodelpath=./bpe_model
#mkdir $bpemodelpath

for bpe_operations in 6000 7000 8000 9000
do
# train BPE on train corpus
echo "Training BPE..."
cat $inputpath/train/train.tok.$src $inputpath/train/train.tok.$trg | $subwordpath/learn_bpe.py -s $bpe_operations -o $bpemodelpath/$src$trg.bpe-$bpe_operations

$subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe-$bpe_operations < $inputpath/train/train.tok.$src > $inputpath/train/train.tok.bpe-$src$trg-$bpe_operations.$src
#|\
#$subwordpath/get_vocab.py > $inputpath/train/train.tok.bpe-$src$trg.$src.vocab

$subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe-$bpe_operations < $inputpath/train/train.tok.$trg > $inputpath/train/train.tok.bpe-$src$trg-$bpe_operations.$trg
#|\
#$subwordpath/get_vocab.py > $inputpath/train/train.tok.bpe-$src$trg.$trg.vocab
echo "... done."
done
