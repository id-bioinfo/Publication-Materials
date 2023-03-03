#! usr/bin/perl -w
 
use strict;
use Data::Dumper qw(Dumper);
sub chomp2{ $_[0] =~ s/[\n\r]//gi; }

print "The following script is written by Dr. Marcus Shum Ho Hin\n All copyright belongs to Dr. Marcus Shum Ho Hin\nDate 19/01/2023\n";

print "\nThe aligned amino acid fasta to aligned nucleotide fasta script is currently running...... Please wait.....\n\n";

##Defining the variables
my $line;
my $name;
my $k;
my $output;
my $nucl;
my $amino;
my $length;
my $i;
my $pos;
my $rec;

my %seq;

##Opening up the file variables
my $nuclfasta = $ARGV[0];
chomp2 $nuclfasta;
open(NUCL, "$nuclfasta");

my $protfasta = $ARGV[1];
chomp2 $protfasta;
open(PROT, "$protfasta");

##Generating the fasta file where the aligned nucleotide sequences will be printed out
my $filename = $protfasta."_nucleotide";
open(my $fn, '>', $filename) or die "Could not open '$filename' $!";

##Starting of the aligned amino acid to the aligned nucleotide sequence process
while($line = <NUCL>){
	chomp2 $line;
	$name = $line;
	$line = <NUCL>;
	chomp2 $line;
	$seq{$name} = $line;
}

while($line = <PROT>){
	$k = 0;
	$output = "";
	chomp2 $line;
	$name = $line;
	$line = <PROT>;
	chomp2 $line;
	$nucl = $seq{$name};
	$amino = $line."*";
	$length = length($amino);

	for($i = 0; $i < $length; $i++){
		$pos = substr $amino, $i, 1;
		if($pos eq "-"){
			$output = $output."---";
		}
		else{
			$rec = substr $nucl, $k, 3;
			$output = $output.$rec;
			$k=$k+3;
		}
	}
	print $fn $name."\n".$output."\n";

}

##Close all file variables
close NUCL;
close PROT;
close $fn;

print "Transformation from aligned amino acid sequence to aligned nucleotide sequence has been completed!\n";

exit;
