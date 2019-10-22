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

if len(sys.argv)<6:
    print("trn_data_x trn_data_y tst_data_x tst_data_y clsfr_ID")
    quit()

clsr_names=["Linear SVM", "RBF SVM", "Decision Tree", "Random Forest", "AdaBoost","Naive Bayes"]

classifiers = [SVC(kernel="linear", C=0.025),
    SVC(gamma=2, C=1),
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB()]

df01=pd.read_csv(sys.argv[1], sep='\t',header=0)
df02=pd.read_csv(sys.argv[2], sep='\t',header=0)
x_trn=df01
y_trn=df02.iloc[:,0]
df03=pd.read_csv(sys.argv[3], sep='\t',header=0)
df04=pd.read_csv(sys.argv[4], sep='\t',header=0)
x_pre=df03
y_pre=df04.iloc[:,0]

clf = classifiers[int(sys.argv[5])]
model=clf.fit(x_trn,y_trn)
y_predicted=model.predict(x_pre)
acc=float((y_predicted==y_pre).sum())/float(len(y_pre))
print("Classifier: {0}, Accuracy: {1:.3f}%".format(clsr_names[int(sys.argv[5])], acc))
