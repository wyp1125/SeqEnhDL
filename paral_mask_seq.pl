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
$cmd="perl mask_seq.pl ../genome/$chr.fa  knownGene.bed $chr ../genome_masked/$chr.fa";
system("$cmd");
print "$chr\n";
}
