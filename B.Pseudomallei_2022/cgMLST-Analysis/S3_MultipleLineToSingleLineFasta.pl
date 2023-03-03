#! usr/bin/perl -w
use strict;
use Data::Dumper qw(Dumper);
sub chomp2{ $_[0] =~ s/[\n\r]//gi; }

print "The following script is written by Dr. Marcus Shum Ho Hin\n All copyright belongs to Dr. Marcus Shum Ho Hin\nDate 19/01/2023\n";

print "\nThe transformation of multiple line fasta file to single line fasta file script is currently running...... Please wait.....\n\n";

##Input of Fasta file to be transformed
my $fasta = $ARGV[0];
chomp2 $fasta;
open (FASTA, "$fasta");

##Generation of the output single-lined fasta file
my $filename = $fasta.".single";
open(my $fn, '>', $filename) or die "Could not open '$filename' $!";

##Defining the variables
my $line;
my @sep;
my %record;

##Starting of transformation
$line = <FASTA>;
chomp2 $line;
print $fn $line."\n";

$line = <FASTA>;
chomp2 $line;
$seq=$line;

while($line = <FASTA>){
	chomp2 $line;
	$check = substr $line, 0, 1;
	if($check ne ">"){
		$seq = $seq.$line;
	}
	else{
		print $fn $seq."\n";
		print $fn $line."\n";
		$line = <FASTA>;
		chomp2 $line;
		$seq = $line;
	}
}
print $fn $seq;

##Closing of all the opened file variables
close FASTA;
close $fn;

print "Transformation of the Fasta files are completed!\n";

exit;
