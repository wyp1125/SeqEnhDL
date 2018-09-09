if($#ARGV<3)
{
print "kmer_dict_prefix fea_col input.fa output.fea\n";
exit;
}
open(input,"$ARGV[0].m5.dict");
%k5=();
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line);
$k5{$a[0]}=$a[$ARGV[1]];
}
}
open(input,"$ARGV[0].m7.dict");
%k7=();
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line);
$k7{$a[0]}=$a[$ARGV[1]];
}
}
open(input,"$ARGV[0].m9.dict");
%k9=();
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line);
$k9{$a[0]}=$a[$ARGV[1]];
}
}
open(input,"$ARGV[0].m11.dict");
%k11=();
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line);
$k11{$a[0]}=$a[$ARGV[1]];
}
}
open(input,"$ARGV[2]");
open(output,">$ARGV[3]");
while($line=<input>)
{
chomp($line);
if($line ne "")
{
if($line=~/\>/)
{
$header=substr($line,1);
}
else
{
$n=length($line);
$fea5=$fea7=$fea9=$fea11=$header;
for($i=5;$i<$n-5;$i++)
{
$m5=substr($line,$i-2,5);
$m7=substr($line,$i-3,7);
$m9=substr($line,$i-4,9);
$m11=substr($line,$i-5,11);
if(exists $k5{$m5})
{
$fea5=$fea5."\t".$k5{$m5};
}
else
{
$fea5=$fea5."\t0.01";
}
if(exists $k7{$m7})
{
$fea7=$fea7."\t".$k7{$m7};
}
else
{
$fea7=$fea7."\t0.01";
}
if(exists $k9{$m9})
{
$fea9=$fea9."\t".$k9{$m9};
}
else
{
$fea9=$fea9."\t0.01";
}
if(exists $k11{$m11})
{
$fea11=$fea11."\t".$k11{$m11};
}
else
{
$fea11=$fea11."\t0.01";
}
}
print output $fea5,"\n";
print output $fea7,"\n";
print output $fea9,"\n";
print output $fea11,"\n";
}
}
}



