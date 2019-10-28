@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl get_kmer_dict.pl sequences/$a[$i].filtered.fa ctl_dict/$a[$i].dict.filtered.ctl.fa kmerdict/$a[$i].ctl";
print $cmd,"\n";
system($cmd);
}
