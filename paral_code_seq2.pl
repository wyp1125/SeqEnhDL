@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
@s=("pos","neg");
@n=("fa","ctl.fa");
@x=("","2");
for($i1=0;$i1<9;$i1++)
{
for($i2=0;$i2<2;$i2++)
{
$cmd="perl code_seq.pl ../kmerdict2/$a[$i1].ctl 1 ../segmentation$x[$i2]/$a[$i1].str_enh.210bp.filtered.$n[$i2] ../feature2/$a[$i1].$s[$i2].fea";
print $cmd,"\n";
system($cmd);
}
}
