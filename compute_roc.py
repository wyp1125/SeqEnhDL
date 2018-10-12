import numpy as np
from sklearn import metrics
import sys
if len(sys.argv)<5:
    print("input col_id_ytrue col_id_yscore output")
data=np.loadtxt(sys.argv[1],delimiter='\t')
ytrue=data[:,int(sys.argv[2])]
yscore=data[:,int(sys.argv[3])]
fpr,tpr,thresholds=metrics.roc_curve(ytrue,yscore)
with open(sys.argv[4],"w") as of:
    for i in range(0,len(fpr)):
        of.write(str(fpr[i])+'\t'+str(tpr[i])+'\n')

