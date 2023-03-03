#! usr/bin/perl -w
 
use strict;
use Data::Dumper qw(Dumper);
sub chomp2{ $_[0] =~ s/[\n\r]//gi; }

print "The following script is written by Dr. Marcus Shum Ho Hin\n All copyright belongs to Dr. Marcus Shum Ho Hin\nDate 19/01/2023\n";

print "\nThe Nucleotide To Amino Acid script is currently running...... Please wait.....\n\n";

my $line;
my $name;
my $nucl_time;
my $nucl_limit;
my $codon;
my $amino;
my $marker;
my $k;

my $fasta = $ARGV[0];
chomp2 $fasta;
open(FASTA, "$fasta");

my $filename = $fasta."_protein";
open(my $fn, '>', $filename) or die "Could not open '$filename' $!";


my %amino_table = (
	'TTT' => 'F', 'TTG' => 'L', 'CTT' => 'L', 'CTC' => 'L', 'CTA' => 'L', 'CTG' => 'L',
	'TTC' => 'F', 'ATT' => 'I', 'ATC' => 'I', 'ATA' => 'I', 'ATG' => 'M', 'GTT' => 'V',
	'TTA' => 'L', 'GTC' => 'V', 'GTA' => 'V', 'GTG' => 'V', 'TCT' => 'S', 'TCC' => 'S',
	'TCA' => 'S', 'TCG' => 'S', 'CCT' => 'P', 'CCC' => 'P', 'CCA' => 'P', 'CCG' => 'P',
	'ACT' => 'T', 'ACC' => 'T', 'ACA' => 'T', 'ACG' => 'T', 'GCT' => 'A', 'GCC' => 'A',
	'GCA' => 'A', 'GCG' => 'A', 'TAT' => 'Y', 'TAC' => 'Y', 'TAA' => '*' , 'TAG' => '*' ,
	'CAT' => 'H', 'CAC' => 'H', 'CAA' => 'Q', 'CAG' => 'Q', 'AAT' => 'N', 'AAC' => 'N',
	'AAA' => 'K', 'AAG' => 'K', 'GAT' => 'D', 'GAC' => 'D', 'GAA' => 'E', 'GAG' => 'E',
	'TGT' => 'C', 'TGC' => 'C', 'TGA' => '*' , 'TGG' => 'W', 'CGT' => 'R', 'CGC' => 'R',
	'CGA' => 'R', 'CGG' => 'R', 'AGT' => 'S', 'AGC' => 'S', 'AGA' => 'R', 'AGG' => 'R',
	'GGT' => 'G', 'GGC' => 'G', 'GGA' => 'G', 'GGG' => 'G', '---' => '-'
);

while ($line = <FASTA>){
	chomp2 $line;
	$name = $line;
	$line = <FASTA>;
	chomp2 $line;
	
	$nucl_limit = length($line)-2;
	$nucl_time = length($line)/3;
	$codon = substr $line, 0, 3;
	if(exists($amino_table{$codon})){
		$amino=$amino_table{$codon};
	}
	else{
		$amino="X";
	}
	$marker = 3;
	for($k = 0;$k <$nucl_time; $k++){
		if($marker < $nucl_limit){
			$codon = substr $line, $marker, 3;
			if(exists($amino_table{$codon})){
				$amino = $amino.$amino_table{$codon};
				$marker = $marker+3;
			}
			else{
				$amino = $amino."X";
				$marker = $marker+3;
			}
		}
	}
	print $fn $name."\n".$amino."\n";
}

##Closing all the opened file variables
close FASTA;
close $fn;

print "Translation from nucleotide sequence to amino acid sequence has been completed!\n";
exit;
