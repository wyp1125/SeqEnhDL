if($#ARGV<2)
{
print "input_pos_fasta input_neg_fasta output_pref\n";
exit;
}
%h5=();
%h7=();
%h9=();
%h11=();
open(input,"$ARGV[0]");
$x=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
if($line!~/\>/)
{
$n=length($line);
for($i=5;$i<$n-5;$i++)
{
$m5=substr($line,$i-2,5);
$m7=substr($line,$i-3,7);
$m9=substr($line,$i-4,9);
$m11=substr($line,$i-5,11);
$h5{$m5}++;
$h7{$m7}++;
$h9{$m9}++;
$h11{$m11}++;
}
$x++;
}
}
}
%k5=();
%k7=();
%k9=();
%k11=();
open(input,"$ARGV[1]");
$y=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
if($line!~/\>/)
{
$n=length($line);
for($i=5;$i<$n-5;$i++)
{
$m5=substr($line,$i-2,5);
$m7=substr($line,$i-3,7);
$m9=substr($line,$i-4,9);
$m11=substr($line,$i-5,11);
$k5{$m5}++;
$k7{$m7}++;
$k9{$m9}++;
$k11{$m11}++;
}
$y++;
}
}
}

open(output1,">$ARGV[2].m5.dict");
foreach $key (keys %h5)
{
if(exists $k5{$key})
{
$stat1=$h5{$key}*$y/($k5{$key}*$x);
print output1 "$key\t$stat1\t$h5{$key}\t$x\t$k5{$key}\t$y\n";
}
else
{
$stat1=$h5{$key}*$y/$x;
print output1 "$key\t$stat1\t$h5{$key}\t$x\t1\t$y\n";
}
}
open(output2,">$ARGV[2].m7.dict");
foreach $key (keys %h7)
{
if(exists $k7{$key})
{
$stat1=$h7{$key}*$y/($k7{$key}*$x);
print output2 "$key\t$stat1\t$h7{$key}\t$x\t$k7{$key}\t$y\n";
}
else
{
$stat1=$h7{$key}*$y/$x;
print output2 "$key\t$stat1\t$h7{$key}\t$x\t1\t$y\n";
}
}
open(output3,">$ARGV[2].m9.dict");
foreach $key (keys %h9)
{
if(exists $k9{$key})
{
$stat1=$h9{$key}*$y/($k9{$key}*$x);
print output3 "$key\t$stat1\t$h9{$key}\t$x\t$k9{$key}\t$y\n";
}
else
{
$stat1=$h9{$key}*$y/$x;
print output3 "$key\t$stat1\t$h9{$key}\t$x\t1\t$y\n";
}
}
open(output4,">$ARGV[2].m11.dict");
foreach $key (keys %h11)
{
if(exists $k11{$key})
{
$stat1=$h11{$key}*$y/($k11{$key}*$x);
print output4 "$key\t$stat1\t$h11{$key}\t$x\t$k11{$key}\t$y\n";
}
else
{
$stat1=$h11{$key}*$y/$x;
print output4 "$key\t$stat1\t$h11{$key}\t$x\t1\t$y\n";
}
}

