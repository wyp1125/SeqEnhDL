@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="./a.out ../genome_masked_$a[$i] ../segmentation/$a[$i].str_enh.210bp.filtered.fea ../segmentation2/$a[$i].str_enh.210bp.filtered.neg.fa 0.01 0 1";
print $cmd,"\n";
system($cmd);
}
