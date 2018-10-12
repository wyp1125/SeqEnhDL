import matplotlib.pyplot as plt
import numpy as np
import sys
if len(sys.argv)<2:
    print("output_file roc_files[',' separated] legends[',' separated]")
    quit()
rocfile=sys.argv[2].split(',')
lnlegnd=sys.argv[3].split(',')
fig = plt.figure(figsize=(4.5, 4.5))
for i in range(0,len(rocfile)):
    data=np.loadtxt(rocfile[i],delimiter='\t')
    plt.plot(data[:,0],data[:,1])
plt.legend(lnlegnd,loc='lower right')
plt.plot([0,1],[0,1],linestyle='dashed')
plt.xlabel('False positive rate')
plt.ylabel('True positive rate')
plt.title('ROC curve')
fig.savefig(sys.argv[1],dpi=400)
