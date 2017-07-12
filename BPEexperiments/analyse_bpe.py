#Adapted from Josiah Wang's script

import numpy as np
import operator

inFolder = '../../../datasets/wmt17_mmt/task1/train/BPEsegmentedCorpus/'

counts = [3000, 6000, 9000, 12000, 15000, 18000, 21000, 24000, 27000, 30000]

srcLang = "en"
trgLang = "de"

filename = '{}{}.{}.{}'

for count in counts:
    bytefreq = {}
    originalfreq = {}
    continuer = 0
    for lang in [srcLang, trgLang]:
        newfilename = filename.format(srcLang, trgLang, count, lang)
        for line in open(inFolder + newfilename):
            row = line.strip().split()
            for token in row:
		if continuer==0:
		    if '@@' in token:
                	bytefreq[token] = bytefreq.get(token, 0) + 1
			continuer=1
			orig = token
		else:
		    if '@@' in token:
			bytefreq[token] = bytefreq.get(token, 0) + 1
			continuer=1
			orig = orig+token
		    else:
			bytefreq[token] = bytefreq.get(token, 0) + 1
			continuer=0
			orig = orig+token
			originalfreq[orig] = originalfreq.get(orig, 0) + 1
			orig = None
	    
    sorted_bytefreq = sorted(bytefreq.items(), key=operator.itemgetter(1))
    sorted_originalfreq = sorted(originalfreq.items(), key=operator.itemgetter(1))

#    (hist, bins) = np.histogram(list(freq.values()), range(1, max(list(freq.values()))+1));
    print("BPE Merge Operations: {}".format(count));
    print sorted_bytefreq[:100]
    print '\n\n'
    print sorted_originalfreq[:100]
    print '\n====================================\n'
#    print();


    (hist, bins) = np.histogram(list(bytefreq.values()), range(1, max(list(bytefreq.values()))+1));
    print("Histogram of bytes")
    print(hist[:100])


    (hist, bins) = np.histogram(list(originalfreq.values()), range(1, max(list(originalfreq.values()))+1));
    print("Histogram of originals")
    print(hist)
