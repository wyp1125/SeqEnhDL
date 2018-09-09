@a=("gm12878","hepg2");
@s=("trn","pre");
@n=("pos","neg");
@b=(1,0);
@f=("1f","2f","3f");
for($i1=0;$i1<2;$i1++)
{
for($i2=0;$i2<3;$i2++)
{
for($i3=0;$i3<2;$i3++)
{
for($i4=0;$i4<2;$i4++)
{
$cmd="perl make_svm_fea.pl ../train_test/$a[$i1].$f[$i2].0.8.$s[$i3].$n[$i4].fea ../svm_train_test/$a[$i1].$f[$i2].0.8.$s[$i3].$n[$i4].fea $b[$i4]";
print $cmd,"\n";
system($cmd);
}
}
}
}
