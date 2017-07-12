# Chiraag Lala on (11July2017)

# apply bpe for all hyperparameter values

applybpe=../apply_bpe.py # apply_bpe.py located one folder above

codepath=../../../datasets/wmt17_mmt/task1/train/BPEcodes # location of the folder containing all BPE code files

src=en # Source Language

trg=fr # Target Language

srcfile=../../../datasets/wmt17_mmt/task1/train/train.$src.tok
trgfile=../../../datasets/wmt17_mmt/task1/train/train.$trg.tok

outputfolder=../../../datasets/wmt17_mmt/task1/train/BPEsegmentedCorpus

for mergeoperations in "3000" "6000" "9000" "12000" "15000" "18000" "21000" "24000" "27000" "30000"
do
  echo "Applying $src$trg.$mergeoperations.bpe ..."
  python $applybpe -c $codepath/$src$trg.$mergeoperations.bpe < $srcfile > $outputfolder/$src$trg.$mergeoperations.$src
  python $applybpe -c $codepath/$src$trg.$mergeoperations.bpe < $trgfile > $outputfolder/$src$trg.$mergeoperations.$trg
  echo "... done."
done
