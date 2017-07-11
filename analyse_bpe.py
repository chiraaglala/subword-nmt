# Original script by Josiah Wang. Edited by Chiraag Lala.

import numpy as np

inFolder = '/home/multimt/datasets/wmt17_mmt/task1/train/';

#counts = [5000, 10000, 15000, 20000];
counts = [1000, 2000, 3000, 4000, 4500, 5000, 6000, 7000, 8000, 9000, 10000, 15000, 20000, 30000];

srcLang = "en";
trgLang = "de";

filename = 'train.tok.bpe-{}{}-{}.{}';

for count in counts:
    freq = {}
    for lang in [srcLang, trgLang]:
        newfilename = filename.format(srcLang, trgLang, count, lang);
        for line in open(inFolder + newfilename, encoding='utf-8'):
            row = line.strip().split();
            for token in row:
                if '@' in token:
                    freq[token] = freq.get(token, 0) + 1;

        '''
    dist = {};
    # generate distribution of token freq
    for (token, f) in freq.items():
        dist[f] = dist.get(f, 0) + 1;
        '''

    (hist, bins) = np.histogram(list(freq.values()), range(1, max(list(freq.values()))+1));
    print("BPE Merge Operations: {}".format(count));
    print(hist[:100]);
    print();
