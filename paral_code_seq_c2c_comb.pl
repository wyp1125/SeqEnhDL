@a=("gm12878","H1hesc","hepg2","Hmec","Hsmm","Huvec","K562","Nhek","Nhlf");
@b=("trn","tst");
for($i1=0;$i1<9;$i1++)
{
  for($i2=0;$i2<9;$i2++)
  {
    if($i1!=$i2)
    {
      for($j=0;$j<2;$j++)
      {
        $o1="feature_cv_c2c_comb/$a[$i1]_$a[$i2].X.$b[$j]";
        $o2="feature_cv_c2c_comb/$a[$i1]_$a[$i2].Y.$b[$j]";
        open(output1,">$o1");
        open(output2,">$o2");
        $x1="feature_cv_c2c/$a[$i1].$a[$i1]_$a[$i2].X.$b[$j]";
        open(input,"$x1");
        while($line=<input>)
        {
          print output1 $line;
          print output2 "1\t0\n";
        }
        $x2="feature_cv_c2c/$a[$i2].$a[$i1]_$a[$i2].X.$b[$j]";
        open(input,"$x2");
        while($line=<input>)
        {
          print output1 $line;
          print output2 "0\t1\n";
        }
      }
    }
  }
}
