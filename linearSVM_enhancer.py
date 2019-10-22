import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.metrics import roc_curve
from sklearn.metrics import auc

if len(sys.argv)<5:
    print("trn_data_x trn_data_y tst_data_x tst_data_y")
    quit()

df01=pd.read_csv(sys.argv[1], sep='\t',header=0)
df02=pd.read_csv(sys.argv[2], sep='\t',header=0)
x_trn=df01
y_trn=df02.iloc[:,0]
df03=pd.read_csv(sys.argv[3], sep='\t',header=0)
df04=pd.read_csv(sys.argv[4], sep='\t',header=0)
x_pre=df03
y_pre=df04.iloc[:,0]

clf=SVC(kernel="linear", C=0.025, probability=True)
model=clf.fit(x_trn,y_trn)
y_predicted=model.predict(x_pre)
y_score=model.predict_proba(x_pre)
acc=float((y_predicted==y_pre).sum())/float(len(y_pre))
print("Accuracy: {0:.3}".format(acc))
y_prob=y_score[:,1]
fpr, tpr, threshold = roc_curve(y_pre, y_prob)
y_auc = auc(fpr,tpr)
print("AUC: {0:.3}".format(y_auc))
