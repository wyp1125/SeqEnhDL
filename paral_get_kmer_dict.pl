@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl get_kmer_dict2.pl ../segmentation/$a[$i].str_enh.210bp.filtered.fa ../segmentation/$a[$i].str_enh.210bp.filtered.ctl.fa ../kmerdict/$a[$i].ctl";
print $cmd,"\n";
system($cmd);
}
