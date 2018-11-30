@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl divide_200bp.pl ../segmentation/$a[$i].strong_enhancer.bed ../segmentation/$a[$i].str_enh.210bp.bed";
print $cmd,"\n";
system($cmd);
}
