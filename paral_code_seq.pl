@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
@s=("pos","neg");
@n=("fa","ctl.fa");
for($i1=0;$i1<9;$i1++)
{
for($i2=0;$i2<2;$i2++)
{
$cmd="perl code_seq.pl ../kmerdict/$a[$i1].ctl 1 ../segmentation/$a[$i1].str_enh.210bp.filtered.$n[$i2] ../feature/$a[$i1].$s[$i2].fea";
print $cmd,"\n";
system($cmd);
}
}
