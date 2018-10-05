import sys
import random
if len(sys.argv)<4:
    print("input output number/ratio")
    quit()
line=open(sys.argv[1],'r')
data=[]
for eachline in line:
    data.append(eachline.strip())
m=len(data)
n=float(sys.argv[3])
if n<=1.0:
   n=m*n
n=int(n)
ndata=random.sample(data,n)
with open(sys.argv[2],'w') as of:
    for eachline in ndata:
        of.write(eachline+'\n')
print(m)
print(n)
