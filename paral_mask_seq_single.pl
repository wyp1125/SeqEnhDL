@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($j=0;$j<9;$j++)
{
for($i=1;$i<=25;$i++)
{
$chr="chr$i";
if($i==23)
{
$chr="chrX";
}
if($i==24)
{
$chr="chrY";
}
if($i==25)
{
$chr="chrM";
}
print $chr,"\n";
$cmd="perl mask_seq.pl ../genome_masked/$chr.fa  ../segmentation/$a[$j].strong_enhancer.bed $chr ../genome_masked_$a[$j]/$chr.fa";
system("$cmd");
#print "$chr\n";
}
}
