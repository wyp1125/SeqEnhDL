open(output,">all.accuracies");
for($i=0;$i<6;$i++)
{
    for($j=1;$j<=5;$j++)
    {
         $cmd="python3 multi_ml_enhancer.py hepg2.1f.0.8.trn.fea.rnd.$j hepg2.1f.0.8.pre.fea $i";
         $b=`$cmd`;
         print $b;
         print output $b;    
    }
}
