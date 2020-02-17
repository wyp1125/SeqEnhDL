import sys
import random
if len(sys.argv)<4:
    print("input_x input_y output_x output_y number[ratio]")
    quit()
line=open(sys.argv[1],'r')
data_x=[]
for eachline in line:
    data_x.append(eachline.strip())
line=open(sys.argv[2],'r')
data_y=[]
for eachline in line:
    data_y.append(eachline.strip())
m=len(data_y)
n=float(sys.argv[5])
if n<=1.0:
   n=m*n
n=int(n)
x=[i for i in range(0,m)]
sel=random.sample(x,n)
with open(sys.argv[3],'w') as of1:
  with open(sys.argv[4],'w') as of2:
    for i in range(0,n):
        of1.write(data_x[sel[i]]+'\n')
        of2.write(data_y[sel[i]]+'\n')
print(m)
print(n)
