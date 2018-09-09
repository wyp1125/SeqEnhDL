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
$cmd="perl mask_seq.pl ../genome_masked/$chr.fa  hepg2.strong_enhancer.bed $chr ../genome_masked_hepg2/$chr.fa";
system("$cmd");
print "$chr\n";
}
