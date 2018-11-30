@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
for($i=0;$i<9;$i++)
{
$cmd="perl divide_feature_unbalance.pl ../feature/$a[$i].pos.fea ../feature/$a[$i].neg.fea ../feature/$a[$i] 0.8";
print $cmd,"\n";
system($cmd);
}
