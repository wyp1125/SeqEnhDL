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

if len(sys.argv)<4:
    print("trn_data pre_data clsfr_ID")
    quit()

clsr_names=["Linear SVM", "RBF SVM", "Decision Tree", "Random Forest", "AdaBoost","Naive Bayes"]

classifiers = [SVC(kernel="linear", C=0.025),
    SVC(gamma=2, C=1),
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB()]

df01=pd.read_csv(sys.argv[1], sep=' ',header=0)
#print(df01.shape)
x_trn=df01.iloc[:,1:]
y_trn=df01.iloc[:,0]
#print(x_trn.shape)
#print(y_trn.shape)

df02=pd.read_csv(sys.argv[2], sep=' ',header=0)
#print(df02.shape)
x_pre=df02.iloc[:,1:]
y_pre=df02.iloc[:,0]
#print(x_pre.shape)
#print(y_pre.shape)

clf = classifiers[int(sys.argv[3])]
model=clf.fit(x_trn,y_trn)
y_predicted=model.predict(x_pre)
acc1=float((y_predicted==y_pre).sum())/float(len(y_pre))
print("Classifier: {0}, Accuracy: {1:.3f}%".format(clsr_names[int(sys.argv[3])], acc1))
