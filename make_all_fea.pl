@a=("gm12878","hepg2");
@s=("pos","neg");
@n=("fa","control.fa");
@f=("1f","2f","3f");
for($i1=0;$i1<2;$i1++)
{
for($i2=0;$i2<2;$i2++)
{
for($i3=0;$i3<3;$i3++)
{
$cmd="perl code_seq.pl ../kmerdict/$a[$i1].$f[$i3] 1 ../segmentation/$a[$i1].strong_enhancer.210bp.filtered.$n[$i2] ../feature/$a[$i1].$s[$i2].$f[$i3].fea";
print $cmd,"\n";
system($cmd);
}
}
}
