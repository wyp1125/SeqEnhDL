if($#ARGV<2)
{
    print "input.fea output.fea label\n";
    exit;
}
open(input,"$ARGV[0]");
open(output,">$ARGV[1]");
$i=0;
$fea=$ARGV[2];
while($line=<input>)
{
    chomp($line);
    @a=split("\t",$line,2);
    if($i%4==0)
    {
        if($i>0)
        {
            $fea=~s/\t/ /g;
            print output $fea,"\n";
        }
        $fea=$ARGV[2]."\t".$a[1];
    }
    else
    {
        $fea=$fea."\t".$a[1];
    }
    $i++;
}
$fea=~s/\t/ /g;
print output $fea,"\n";
