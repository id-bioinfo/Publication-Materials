#! usr/bin/perl -w

use strict;
use Data::Dumper qw(Dumper);
sub chomp2{ $_[0] =~ s/[\n\r]//gi; }

print "The following script is written by Dr. Marcus Shum Ho Hin\n All copyright belongs to Dr. Marcus Shum Ho Hin\nDate 19/01/2023\n";

print "\nThe multiple sequence aligned single-copy cgMLST concatinatiing script is currently running...... Please wait.....\n\n";

##Input of List of names of single-copy cgMLST fasta files (multiple sequence aligned)
my $list = $ARGV[0];
chomp2 $list;
open (LIST, "$list");

##Generation of the output fasta file containing the concatinated sequneces
my $filename = $list.".ConcatinatedSequence";
open(my $fn, '>', $filename) or die "Could not open '$filename' $!";

##Defining the variables
my $line;
my $fasta;
my $tmp;
my $name;
my $i=0;
my $j;

my %sequence;
my %record;

##Starting of the concatination
while($line = <LIST>){
	chomp2 $line;
	$fasta = $line;
	open (FASTA, "$fasta");
	while($tmp = <FASTA>){
		chomp2 $tmp;
		$name = substr $tmp, 1;
		$tmp = <FASTA>;
		chomp2 $tmp;
		if($name =~ "-"){
			@sep = split /\_/, $name;
			$name = $sep[0];
		}
		else{
			@sep = split /\./, $name;
			@sep2 = split /\_/, $sep[1];
			$name = $sep[0].".".$sep2[1];
		}
		if(exists($sequence{$name})){
			$sequence{$name} = $sequence{$name}.$tmp;
		}
		else{
			$sequence{$name} = $tmp;
			$record{$i} = $name;
			$i=$i+1;
		}
	}
	close FASTA;
}

for($j=0;$j<$i;$j++){
	print $fn $record{$j}."\n".$sequence{$record{$j}}."\n";
}

##Closing of all the opened file variables
close LIST;
close $fn;

print "Concatinating of the gene sequences has been completed!\n";
exit;

	