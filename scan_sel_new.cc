#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vector>
#include <map>
#include <time.h>
using namespace std;
vector <char> new_seq;
map <string, long int> chr2pos;
vector <long int> chrpos;
double cvg_gc,cvg_n;
double cur_gc_r,cur_n_r;
int cur_gc,cur_n;
int fold=1;
long int genome_size;
char cur_nt;
struct fea
{
string chr_nm;
long int abs_ps;
long int chr_ps;
int win_ln;
double gc_rt;
double n_rt;
int status;
};
vector <fea> res;
void read_chr(const char *chr_path)
{
char fn[400];
int i;
string chr_name,temp;
for(i=0;i<23;i++)
{
if(i==22)
{
sprintf(fn,"%s/chrX.fa",chr_path);
chr_name="chrX";
}
else if(i==23)
{
sprintf(fn,"%s/chrY.fa",chr_path);
chr_name="chrY";
}
else
{
sprintf(fn,"%s/chr%d.fa",chr_path,i+1);
char tt[10];
sprintf(tt,"%d",i+1);
chr_name="chr"+string(tt);
}
cout<<chr_name<<" "<<fn<<endl;
int j;
ifstream cfl;
cfl.open(fn);
getline(cfl,temp);
chr2pos[chr_name]=new_seq.size();
chrpos.push_back(new_seq.size());
cout<<new_seq.size()<<endl;
while(!cfl.eof())
{
getline(cfl,temp);
for(j=0;j<temp.length();j++)
{
new_seq.push_back(temp[j]);
}
}
cfl.close();
}
genome_size=new_seq.size();
}
void output(const char* path)
{
ofstream res_fl;
res_fl.open(path,ios::out);
char log_fl[400];
sprintf(log_fl,"%s.log",path);
ofstream res_lg;
res_lg.open(log_fl,ios::out);
long int i,j;
for(i=0;i<res.size();i++)
{
res_fl<<">hg19:"<<res[i].chr_nm<<":"<<res[i].chr_ps<<"-"<<res[i].chr_ps+res[i].win_ln-1<<endl;
res_lg<<res[i].chr_nm<<":"<<res[i].chr_ps<<"-"<<res[i].chr_ps+res[i].win_ln-1<<"\t"<<res[i].gc_rt<<"\t"<<res[i].n_rt<<"\t"<<res[i].status<<endl;
for(j=res[i].abs_ps;j<res[i].abs_ps+res[i].win_ln;j++)
{
res_fl<<new_seq[j];
}
res_fl<<endl;
}
}
void plus_cur()
{
switch(cur_nt)
{
case 'N': cur_n++; break;
case 'X': cur_n++; break;
case 'G': cur_gc++; break;
case 'C': cur_gc++; break;
}
}
void minus_cur()
{
switch(cur_nt)
{
case 'N': cur_n--; break;
case 'X': cur_n--; break;
case 'G': cur_gc--; break;
case 'C': cur_gc--; break;
}
}
void compute_res(long int st,int len, double gc_r,double n_r,int tag)
{
int i;
string temp;
//cout<<st<<endl;
for(i=0;i<chrpos.size();i++)
{
if(chrpos[i]>st)
break;
}
fea temp_fea;
stringstream ss;
ss<<i;
temp="chr"+ss.str();
if(i==23)
temp="chrX";
if(i==24)
temp="chrY";
temp_fea.abs_ps=st;
temp_fea.chr_nm=temp;
temp_fea.chr_ps=st-chrpos[i-1]+1;
temp_fea.win_ln=len;
temp_fea.gc_rt=gc_r;
temp_fea.n_rt=n_r;
temp_fea.status=tag;
res.push_back(temp_fea);
}
int scan(int req_len,double req_gc,double req_n)
{
long int j,best_p;
srand((unsigned)time(NULL)+rand());
long int ran_st=(long int)((double)rand()/(double)RAND_MAX*(double)genome_size-(double)req_len);
//long int ran_st=(int)(rand()%(genome_size-req_len));
//cout<<ran_st<<endl;
cur_gc=0;
cur_n=0;
double diff_gc_r,diff_n_r,best_r,best_gc_r,best_n_r;
for(j=ran_st;j<ran_st+req_len;j++)
{
cur_nt=new_seq[j];
plus_cur();
}
cur_gc_r=(double)cur_gc/(double)(req_len-cur_n);
cur_n_r=(double)cur_n/(double)req_len;
diff_gc_r=fabs(cur_gc_r-req_gc);
diff_n_r=fabs(cur_n_r-req_n);
best_r=diff_gc_r+diff_n_r; best_p=ran_st; best_gc_r=cur_gc_r; best_n_r=cur_n_r;
if(diff_gc_r<=cvg_gc && diff_n_r<=cvg_n)
{
compute_res(ran_st, req_len, cur_gc_r, cur_n_r, 1);
return 1;
}
for(j=ran_st+1;j<genome_size-req_len;j++)
{
cur_nt=new_seq[j-1];
minus_cur();
cur_nt=new_seq[j+req_len-1];
plus_cur();
cur_gc_r=(double)cur_gc/(double)(req_len-cur_n);
cur_n_r=(double)cur_n/(double)req_len;
diff_gc_r=fabs(cur_gc_r-req_gc);
diff_n_r=fabs(cur_n_r-req_n);
if(diff_gc_r+diff_n_r<best_r)
{best_r=diff_gc_r+diff_n_r; best_p=j; best_gc_r=cur_gc_r; best_n_r=cur_n_r;}
if(diff_gc_r<=cvg_gc && diff_n_r<=cvg_n)
{
compute_res(j, req_len, cur_gc_r, cur_n_r, 1);
return 1;
}
}
cur_gc=0;
cur_n=0;
for(j=0;j<req_len;j++)
{
cur_nt=new_seq[j];
plus_cur();
}
cur_gc_r=(double)cur_gc/(double)(req_len-cur_n);
cur_n_r=(double)cur_n/(double)req_len;
diff_gc_r=fabs(cur_gc_r-req_gc);
diff_n_r=fabs(cur_n_r-req_n);
if(diff_gc_r+diff_n_r<best_r)
{best_r=diff_gc_r+diff_n_r; best_p=0; best_gc_r=cur_gc_r; best_n_r=cur_n_r;}
if(diff_gc_r<=cvg_gc && diff_n_r<=cvg_n)
{
compute_res(0, req_len, cur_gc_r, cur_n_r, 1);
return 1;
}
for(j=1;j<ran_st;j++)
{
cur_nt=new_seq[j-1];
minus_cur();
cur_nt=new_seq[j+req_len-1];
plus_cur();
cur_gc_r=(double)cur_gc/(double)(req_len-cur_n);
cur_n_r=(double)cur_n/(double)req_len;
diff_gc_r=fabs(cur_gc_r-req_gc);
diff_n_r=fabs(cur_n_r-req_n);
if(diff_gc_r+diff_n_r<best_r)
{best_r=diff_gc_r+diff_n_r; best_p=j; best_gc_r=cur_gc_r; best_n_r=cur_n_r;}
if(diff_gc_r<=cvg_gc && diff_n_r<=cvg_n)
{
compute_res(j, req_len, cur_gc_r, cur_n_r, 1);
return 1;
}
}
compute_res(best_p, req_len, best_gc_r, best_n_r, 0);
return 1;
}
void read_pos(const char* path)
{
ifstream pfl;
pfl.open(path);
string line, word;
int i=0;
int num_nt,j;
double num_gc, num_n;
while(!pfl.eof())
{
getline(pfl,line);
if(line=="") continue;
cout<<i++<<endl;
istringstream test(line);
getline(test,word,'\t');
getline(test,word,'\t');
num_nt=atoi(word.c_str());
getline(test,word,'\t');
num_gc=atof(word.c_str());
for(j=0;j<fold;j++)
{
scan(num_nt, num_gc, 0);
}
}
}
int main(int argc, char *argv[])
{
if(argc<=6)
{
cout<<"Usage: chromosome_dir input output gc_diff n_diff fold"<<endl;
exit(1);
}
cvg_gc=atof(argv[4]);
cvg_n=atof(argv[5]);
fold=atoi(argv[6]);
int i,j;
cout<<"Reading chromosomes"<<endl;
read_chr(argv[1]);
cout<<"Scanning chromosomes"<<endl;
read_pos(argv[2]);
cout<<"Outputing"<<endl;
output(argv[3]);
return 1;
}
