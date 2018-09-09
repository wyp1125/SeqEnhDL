#This program divides a bed file into 210bp windows
if($#ARGV<1)
{
print "input_bed output_bed\n";
exit;
}
open(input,"$ARGV[0]");
open(output,">$ARGV[1]");
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line);
$n=($a[2]-$a[1])/200;
for($i=0;$i<$n;$i++)
{
print output $a[0],"\t",$a[1]+200*$i-5,"\t",$a[1]+200*$i+200+4,"\n";
}
}
}
