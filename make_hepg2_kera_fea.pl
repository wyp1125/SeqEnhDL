open(output1,">hepg2.trn.X");
open(output2,">hepg2.trn.Y");
open(output3,">hepg2.tst.X");
open(output4,">hepg2.tst.Y");
open(input,"hepg2.trn.pos.fea");
$n=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line,2);
if($n%4==0)
{
$nline=$a[1];
}
else
{
$nline=$nline."\t".$a[1];
}
if($n%4==3)
{
print output1 &transpose($nline),"\n";
print output2 "0\t1\n";
}
$n++;
}
}
open(input,"hepg2.trn.neg.fea");
$n=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line,2);
if($n%4==0)
{
$nline=$a[1];
}
else
{
$nline=$nline."\t".$a[1];
}
if($n%4==3)
{
print output1 &transpose($nline),"\n";
print output2 "1\t0\n";
}
$n++;
}
}
open(input,"hepg2.pre.pos.fea");
$n=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line,2);
if($n%4==0)
{
$nline=$a[1];
}
else
{
$nline=$nline."\t".$a[1];
}
if($n%4==3)
{
print output3 &transpose($nline),"\n";
print output4 "0\t1\n";
}
$n++;
}
}
open(input,"hepg2.pre.neg.fea");
$n=0;
while($line=<input>)
{
chomp($line);
if($line ne "")
{
@a=split("\t",$line,2);
if($n%4==0)
{
$nline=$a[1];
}
else
{
$nline=$nline."\t".$a[1];
}
if($n%4==3)
{
print output3 &transpose($nline),"\n";
print output4 "1\t0\n";
}
$n++;
}
}

sub transpose
{
my @b=split("\t",$_[0]);
my $xx="";
for(my $i=0;$i<200;$i++)
{
my $temp=$b[$i]."\t".$b[$i+200]."\t".$b[$i+400]."\t".$b[$i+600]."\t";
$xx=$xx.$temp;
}
chop($xx);
return $xx;
}
