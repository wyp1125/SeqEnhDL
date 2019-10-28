@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
@b=("trn","tst");
for($i1=3;$i1<9;$i1++)
{
for($i2=0;$i2<9;$i2++)
{
if($i1!=$i2)
{
for($j=0;$j<2;$j++)
{
$cmd="perl code_seq2.pl kmerdict_c2c/$a[$i1]_$a[$i2] 1 fasta_positive/$a[$i1].0.$b[$j].pos feature_cv_c2c/$a[$i1].$a[$i1]_$a[$i2].X.$b[$j]";
print $cmd,"\n";
system($cmd);
$cmd="perl code_seq2.pl kmerdict_c2c/$a[$i2]_$a[$i1] 1 fasta_positive/$a[$i1].0.$b[$j].pos feature_cv_c2c/$a[$i1].$a[$i2]_$a[$i1].X.$b[$j]";
print $cmd,"\n";
system($cmd);
}
}
}
}
