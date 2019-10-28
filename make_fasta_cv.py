import sys
import os
from sklearn.utils import shuffle
if len(sys.argv)<4:
  print("input_pos input_neg output_pref fold")
  quit()
fl1=open(sys.argv[1],"r")
fl2=open(sys.argv[2],"r")
pos_all=fl1.readlines()
neg_all=fl2.readlines()
seq=[]
tag=[]
i=0
j=0
for eachLine in pos_all:
  if i%2==0:
    oline=eachLine.strip()
  else:
    oline=oline+"\t"+eachLine
    seq.append(oline)
    tag.append("1\t0\n")
    j=j+1
  i=i+1
i=0
for eachLine in neg_all:
  if i%2==0:
    oline=eachLine.strip()
  else:
    oline=oline+"\t"+eachLine
    seq.append(oline)
    tag.append("0\t1\n")
    j=j+1
  i=i+1
n_indv=j
Xall,Yall=shuffle(seq,tag)
fold=int(sys.argv[4])
size=round(n_indv/fold)
print(size)
for i in range(0,fold):
  with open(sys.argv[3]+"."+str(i)+".X.trn","w") as of1:
    with open(sys.argv[3]+"."+str(i)+".X.tst","w") as of2: 
      with open(sys.argv[3]+"."+str(i)+".Y.trn","w") as of3:
        with open(sys.argv[3]+"."+str(i)+".Y.tst","w") as of4:
          for j in range(0,n_indv):
            if j>=size*i and j<size*(i+1):
              of2.write(Xall[j])
              of4.write(Yall[j])
            else:
              of1.write(Xall[j])
              of3.write(Yall[j])

 

  
