# preprocess individual corpus = normalize-punctuation, lowercase, tokenize

mosespath=/home/multimt/libs/external/mosesdecoder

scriptpath=$mosespath/scripts/tokenizer

inputpath=/home/multimt/datasets/wmt17_mmt/task1

for lang in "en" "de" "fr"
do
  for f in "train" "val" "test2016"
  do
    echo "Processing $f.$lang..."
    perl $scriptpath/normalize-punctuation.perl -l $lang  < $inputpath/$f/$f.$lang | \
    perl $scriptpath/lowercase.perl | \
    perl $scriptpath/tokenizer.perl -l $lang > $inputpath/$f/$f.tok.$lang
    echo "... done."
  done
done

# test 2017 data
lang=en
for f in "source_flickr.task1" "source_mscoco.task1"
do
    echo "Processing $f..."
    perl $scriptpath/normalize-punctuation.perl -l $lang  < $inputpath/test2017/$f | \
    perl $scriptpath/lowercase.perl | \
    perl $scriptpath/tokenizer.perl -l $lang > $inputpath/test2017/$f.tok
    echo "... done."
done
