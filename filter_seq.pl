##########This program generates the input file for random sequence selections from the whole genome#########
if($#ARGV<1)
{
print "Usage:fasta_file output_file\n";
exit;
}
open(input,"$ARGV[0]");
open(output1,">$ARGV[1].fa");
open(output2,">$ARGV[1].fea");
$i=0;
while($line=<input>)
{
chomp($line);
if($line=~/\>/)
{
$title[$i]=$line;
if($i>0)
{
$seq[$i-1]=$temp;
}
$temp="";
$i++;
}
else
{
$temp=$temp.$line;
}
}
$seq[$i-1]=$temp;
for($j=0;$j<$i;$j++)
{
@b=get_gc($seq[$j]);
if($b[0]==1)
{
print output1 $title[$j],"\n",$seq[$j],"\n";
print output2 substr($title[$j],1),"\t",$b[1],"\t",$b[2],"\n";
}
}
sub get_gc
{
my @aa=split("",$_[0]);
my $xx=0;
my %hh=();
$hh{"A"}=0;
$hh{"C"}=0;
$hh{"G"}=0;
$hh{"T"}=0;
for(my $ii=0;$ii<=$#aa;$ii++)
{
if(exists $hh{$aa[$ii]})
{
$hh{$aa[$ii]}++;
$xx++;
}
}
my @rr=($xx/($#aa+1),$#aa+1,($hh{"C"}+$hh{"G"})/($#aa+1));
return @rr;
}
