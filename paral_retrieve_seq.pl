@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl retrieve_seq_correct.pl ../genome_masked ../segmentation/$a[$i].str_enh.210bp.bed ../segmentation/$a[$i].str_enh.210bp.fa";
print $cmd,"\n";
system($cmd);
}
