TEPS:
(1) Preprocess (normalize punctuation, lowercase and tokenize) training files using the `preprocess_norm_lc_tok.sh` script
(2) Concatenate Source and Target files
(3) Learn BPE operations for hyperparameter 3000, 6000, ..., 30000
```./learn_joint_bpe_and_vocab.py --input ../../datasets/wmt17_mmt/task1/train/train.en.tok ../../datasets/wmt17_mmt/task1/train/train.de.tok -s 3000 -o ../../datasets/wmt17_mmt/task1/train/BPEcodes/ende.3000.bpe --write-vocabulary ../../datasets/wmt17_mmt/task1/train/BPEvocabs/ende.3000.en ../../datasets/wmt17_mmt/task1/train/BPEvocabs/ende.3000.de```

(4) Apply BPE operations for each of the hyperparameter values
(5) Get vocab for each of the files
(6) Build histogram
