@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i1=0;$i1<9;$i1++)
{
for($i2=0;$i2<5;$i2++)
{
$cmd="perl code_seq.pl kmerdict/$a[$i1].ctl 1 fasta_cv/$a[$i1].$i2.X.trn feature_cv/$a[$i1].$i2.X.trn";
print $cmd,"\n";
system($cmd);
$cmd="perl code_seq.pl kmerdict/$a[$i1].ctl 1 fasta_cv/$a[$i1].$i2.X.tst feature_cv/$a[$i1].$i2.X.tst";
print $cmd,"\n";
system($cmd);
}
}
