if($#ARGV<2)
{
print("input_seq masked_regions chrID output_seq\n");
exit;
}
$seq=();
open(input,"$ARGV[0]");
open(output,">$ARGV[3]");
$header=<input>;
$n=1;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("",$line);
for($i=0;$i<=$#a;$i++)
{
$seq[$n]=$a[$i];
if(ord($seq[$n])>90)
{
$seq[$n]="N";
}
$n++;
}
}
}
open(input,"$ARGV[1]");
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@b=split("\t",$line);
if($b[0] eq $ARGV[2])
{
for($i=$b[1];$i<=$b[2];$i++)
{
$seq[$i]="X";
}
}
}
}
print output $header;
for($i=1;$i<$n;$i++)
{
print output $seq[$i];
if($i%50==0)
{
print output "\n";
}
}
