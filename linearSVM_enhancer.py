import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.svm import SVC

if len(sys.argv)<4:
    print("trn_data val_data output")
    quit()

clf = SVC(kernel="linear", C=0.025, probability=True)

df01=pd.read_csv(sys.argv[1], sep=' ',header=0)
x_trn=df01.iloc[:,1:]
y_trn=df01.iloc[:,0]

df02=pd.read_csv(sys.argv[2], sep=' ',header=0)
x_pre=df02.iloc[:,1:]
y_pre=df02.iloc[:,0]

model=clf.fit(x_trn,y_trn)
y_predicted=model.predict_proba(x_pre)
with open(sys.argv[3],"w") as of:
    for i in range(0,len(y_pre)):
        tag=0
        if y_predicted[i][1]>y_predicted[i][0]:
            tag=1
        of.write(str(y_pre[i])+'\t'+str(y_predicted[i][0])+'\t'+str(y_predicted[i][1])+'\t'+str(tag)+'\n')
    #print(y_predicted)
