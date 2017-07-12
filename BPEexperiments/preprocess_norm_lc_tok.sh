# Original script by Josiah Wang (11July2017). Edited by Chiraag Lala on (11July2017)

# Preprocessing individual corpus = normalize-punctuation, lowercase, tokenize

mosespath=../../mosesdecoder # Wherever mosesdecoder located

scriptpath=$mosespath/scripts/tokenizer # Location of preprocessing scripts

inputpath=../../../datasets/wmt17_mmt/task1/train/train.fr # Location of the corpus/file that is to be preprocessed

lang=fr

echo "Processing $inputpath..."
perl $scriptpath/normalize-punctuation.perl -l $lang  < $inputpath | \
perl $scriptpath/lowercase.perl | \
perl $scriptpath/tokenizer.perl -l $lang > $inputpath.tok
echo "... done."

