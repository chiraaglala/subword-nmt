# preprocess individual corpus = normalize-punctuation, lowercase, tokenize

src=en
trg=de

bpe_operations=20000

mosespath=/home/multimt/libs/external/mosesdecoder

scriptpath=$mosespath/scripts/tokenizer

subwordpath=/home/multimt/libs/external/subword-nmt

inputpath=/home/multimt/datasets/wmt17_mmt/task1

bpemodelpath=./bpe_model
#mkdir $bpemodelpath

# train BPE on train corpus
echo "Training BPE..."
cat $inputpath/train/train.tok.$src $inputpath/train/train.tok.$trg | $subwordpath/learn_bpe.py -s $bpe_operations -o $bpemodelpath/$src$trg.bpe

$subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe < $inputpath/train/train.tok.$src |\
$subwordpath/get_vocab.py > $inputpath/train/train.tok.bpe-$src$trg.$src.vocab

$subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe < $inputpath/train/train.tok.$trg |\
$subwordpath/get_vocab.py > $inputpath/train/train.tok.bpe-$src$trg.$trg.vocab
echo "... done."

# apply BPE
for f in "train" "val" "test2016"
do
  echo "Processing $f..."
  $subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe < $inputpath/$f/$f.tok.$src > $inputpath/$f/$f.tok.bpe-$src$trg.$src
  $subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe < $inputpath/$f/$f.tok.$trg > $inputpath/$f/$f.tok.bpe-$src$trg.$trg
  echo "... done."
done

# test 2017 data
for f in "source_flickr.task1" "source_mscoco.task1"
do
    echo "Processing $f..."
    $subwordpath/apply_bpe.py -c $bpemodelpath/$src$trg.bpe < $inputpath/test2017/$f.tok > $inputpath/test2017/$f.tok.bpe-$src$trg
    echo "... done."
done
