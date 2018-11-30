@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl filter_seq.pl ../segmentation/$a[$i].str_enh.210bp.fa ../segmentation/$a[$i].str_enh.210bp.filtered";
print $cmd,"\n";
system($cmd);
}
