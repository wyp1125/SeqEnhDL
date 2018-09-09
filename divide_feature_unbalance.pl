#!/usr/local/bin/perl
if($#ARGV<3)
{
print "pos_input neg_input output_prefix ratio\n";
exit;
}
open(input,"$ARGV[0]");
$i=0;
$unit="";
while($line=<input>)
{
if($i%4==0)
{
if($i>0)
{
$pos_fea[$i/4-1]=$unit;
}
$unit=$line;
}
else
{
$unit=$unit.$line;
}
$i++;
}
$pos_fea[$i/4-1]=$unit;
$m=$i/4;
open(input,"$ARGV[1]");
$i=0;
$unit="";
while($line=<input>)
{
if($i%4==0)
{
if($i>0)
{
$neg_fea[$i/4-1]=$unit;
}
$unit=$line;
}
else
{
$unit=$unit.$line;
}
$i++;
}
$neg_fea[$i/4-1]=$unit;
$n=$i/4;
$f=$n/$m;
@sel=ran_sel($m,$m);
open(output1,">$ARGV[2].trn.pos.fea");
open(output2,">$ARGV[2].trn.neg.fea");
open(output3,">$ARGV[2].pre.pos.fea");
open(output4,">$ARGV[2].pre.neg.fea");
for($xx=0;$xx<$m;$xx++)
{
if($xx>=$m*$ARGV[3])
{
print output3 $pos_fea[$sel[$xx]];
for($j=0;$j<$f;$j++)
{
print output4 $neg_fea[$sel[$f*$xx+$j]];
}
}
else
{
print output1 $pos_fea[$sel[$xx]];
for($j=0;$j<$f;$j++)
{
print output2 $neg_fea[$sel[$f*$xx+$j]];
}
}
}

sub ran_sel
{
my %h=();
my $tot=$_[0];
my $sel=$_[1];
my $size=0;
my @a="";
while($size<$sel)
{
$temp=int(rand($tot));
if(!exists $h{$temp})
{
$h{$temp}=1;
$a[$size]=$temp;
$size++;
}
}
return @a;
}

