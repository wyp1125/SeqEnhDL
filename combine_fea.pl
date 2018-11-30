if($#ARGV<3)
{
print "input_pos1[，input_pos2,...] input_neg output_prefix\n";
}
@fl=split(",",$ARGV[0]);
open(output1,">$ARGV[2].cmb.pos.fea");
for($i=0;$i<=$#fl;$i++)
{
open(input,"$fl[$i]");
while($line=<input>)
{
chomp($line);
if(length($line)>0)
{
print output1 ($i+1),"\t",$line,"\n";
}
}
close(input);
}
open(output2,">$ARGV[2].cmb.neg.fea");
open(input,"$ARGV[1]");
while($line=<input>)
{
chomp($line);
if(length($line)>0)
{
print output2 0,"\t",$line,"\n";
}
}
