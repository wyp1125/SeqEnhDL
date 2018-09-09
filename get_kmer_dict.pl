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
$stat2=-log(&pvalue($h5{$key},$x,$h5{$key}+$k5{$key},$x+$y))/log(10);
print output1 "$key\t$stat1\t$stat2\t$h5{$key}\t$x\t$k5{$key}\t$y\n";
}
else
{
$stat1=$h5{$key}*$y/$x;
$stat2=-log(&pvalue($h5{$key},$x,$h5{$key}+1,$x+$y))/log(10);
print output1 "$key\t$stat1\t$stat2\t$h5{$key}\t$x\t1\t$y\n";
}
}
open(output2,">$ARGV[2].m7.dict");
foreach $key (keys %h7)
{
if(exists $k7{$key})
{
$stat1=$h7{$key}*$y/($k7{$key}*$x);
$stat2=-log(&pvalue($h7{$key},$x,$h7{$key}+$k7{$key},$x+$y))/log(10);
print output2 "$key\t$stat1\t$stat2\t$h7{$key}\t$x\t$k7{$key}\t$y\n";
}
else
{
$stat1=$h7{$key}*$y/$x;
$stat2=-log(&pvalue($h7{$key},$x,$h7{$key}+1,$x+$y))/log(10);
print output2 "$key\t$stat1\t$stat2\t$h7{$key}\t$x\t1\t$y\n";
}
}
open(output3,">$ARGV[2].m9.dict");
foreach $key (keys %h9)
{
if(exists $k9{$key})
{
$stat1=$h9{$key}*$y/($k9{$key}*$x);
$stat2=-log(&pvalue($h9{$key},$x,$h9{$key}+$k9{$key},$x+$y))/log(10);
print output3 "$key\t$stat1\t$stat2\t$h9{$key}\t$x\t$k9{$key}\t$y\n";
}
else
{
$stat1=$h9{$key}*$y/$x;
$stat2=-log(&pvalue($h9{$key},$x,$h9{$key}+1,$x+$y))/log(10);
print output3 "$key\t$stat1\t$stat2\t$h9{$key}\t$x\t1\t$y\n";
}
}
open(output4,">$ARGV[2].m11.dict");
foreach $key (keys %h11)
{
if(exists $k11{$key})
{
$stat1=$h11{$key}*$y/($k11{$key}*$x);
$stat2=-log(&pvalue($h11{$key},$x,$h11{$key}+$k11{$key},$x+$y))/log(10);
print output4 "$key\t$stat1\t$stat2\t$h11{$key}\t$x\t$k11{$key}\t$y\n";
}
else
{
$stat1=$h11{$key}*$y/$x;
$stat2=-log(&pvalue($h11{$key},$x,$h11{$key}+1,$x+$y))/log(10);
print output4 "$key\t$stat1\t$stat2\t$h11{$key}\t$x\t1\t$y\n";
}
}

sub pvalue
{
my $k=$_[0];
my $n=$_[1];
my $C=$_[2];
my $G=$_[3];
my $um=min($n,$C);
my $lm=max(0,$n+$C-$G);
if($um==$lm)
{
return 1.0;
}
my $cutoff = hypergeometric_probability($k, $n, $C, $G);
my $right_tail = 0;
for(my $i=$lm;$i<$um+1;$i++)
{
my $p = hypergeometric_probability($i, $n, $C, $G);
if ($i>=$k)
{
$right_tail += $p;
}
}
$right_tail = min($right_tail, 1);
return $right_tail;
}
sub min
{
return $_[0]<$_[1]?$_[0]:$_[1];
}
sub max
{
return $_[0]>$_[1]?$_[0]:$_[1];
}
sub hypergeometric_probability 
{
my $i=$_[0];
my $n=$_[1];
my $C=$_[2];
my $G=$_[3];
return exp(lncombination($C,$i)+lncombination($G-$C,$n-$i)-lncombination($G,$n));
}
sub lncombination
{
my $n=$_[0];
my $p=$_[1];
return lnfactorial($n) - lnfactorial($p) - lnfactorial($n - $p);
}

sub lnfactorial
{
my $n=$_[0];
if($n <= 1)
{return 0;}
else
{return lngamma($n + 1);}
}

sub lngamma
{
my $z=$_[0];
my $x=0;
$x += 0.1659470187408462e-06 / ($z + 7);
$x += 0.9934937113930748e-05 / ($z + 6);
$x -= 0.1385710331296526 / ($z + 5);
$x += 12.50734324009056 / ($z + 4);
$x -= 176.6150291498386 / ($z + 3);
$x += 771.3234287757674 / ($z + 2);
$x -= 1259.139216722289 / ($z + 1);
$x += 676.5203681218835 / ($z);
$x += 0.9999999999995183;

return log($x) - 5.58106146679532777 - $z + ($z - 0.5) * log($z + 6.5);
}
