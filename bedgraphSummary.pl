#!/usr/bin/perl
use strict;
use Cwd;
my $current_dir=getcwd;
chdir getcwd;

my %data;
my @bedGraph=glob("*bedGraph");
foreach my $bedgraph(@bedGraph){
open F,$bedgraph;
my ($avgMeth,$methTotalNum,$unmethTotalNum,$lociNum);
while(<F>){
next if /track/i;
chomp;
my ($chr,$start,$end,$percent,$methNum,$unmethNum)=split /\s+/;
if(defined $percent){
$methTotalNum += $methNum;
$unmethTotalNum +=$unmethNum;
}
$avgMeth=$methTotalNum/($methTotalNum+$unmethTotalNum+1);
$data{$bedgraph}{'mf'}=$avgMeth;
$data{$bedgraph}{'tmr'}=$methTotalNum;
$data{$bedgraph}{'tur'}=$unmethTotalNum;
}
}
print "SampleID\tMethylation Freqency\tNumber of methylated coverage\tNumber of un-methylated coverage\n";
foreach my $file(sort keys %data){
        my ($sample,undef)=split /\./,$file;
        print "$sample\t$data{$file}{'mf'}\t$data{$file}{'tmr'}\t$data{$file}{'tur'}\n";
}
