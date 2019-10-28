@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
for($j=0;$j<9;$j++)
{
if($i!=$j)
{
$cmd="perl get_kmer_dict.pl sequences/$a[$i].filtered.fa sequences/$a[$j].filtered.fa kmerdict_c2c/$a[$i]_$a[$j]";
print $cmd,"\n";
system($cmd);
}
}
}
