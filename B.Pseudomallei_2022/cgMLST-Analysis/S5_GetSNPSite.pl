#! usr/bin/perl -w

use strict;
use Data::Dumper qw(Dumper);
sub chomp2{ $_[0] =~ s/[\n\r]//gi; }

print "The following script is written by Dr. Marcus Shum Ho Hin\n All copyright belongs to Dr. Marcus Shum Ho Hin\nDate 19/01/2023\n";

print "\nThe SNP calling script is currently running...... Please wait.....\n\n";
##Input of the concatinated fasta sequence file where the SNP is being called
my $fasta = $ARGV[0];
chomp2 $fasta;
open (FASTA, "$fasta");

##Generation of the output fasta file where the SNPs are being printed out
my $filename = $fasta.".SNPSite";
open(my $fn, '>', $filename) or die "Could not open '$filename' $!";

##Defining the variables
my $line;
my $name;
my $length;
my $nucl;
my $i;

my %seq;
my %finalseq;

##Starting of the SNP calling
while($line = <FASTA>){
	chomp2 $line;
	$name = $line;
	$line = <FASTA>;
	chomp2 $line;
	$seq{$name} = $line;
	$length=length($line);
	$finalseq{$name} = "";
}

for($i=0;$i<$length;$i++){
	my $tmp = "";
	my $do=0;
	my $tmp2=1;
	foreach my $k(keys %seq){
		$nucl = substr $seq{$k}, $i, 1;
		if($nucl ne "-"){
			if($tmp2 == 1){
				$tmp = $nucl;
				$tmp2 = 2;
			}
			else{
				if($nucl ne $tmp){
					$do=1;
					last;
				}
			}
		}
	}
	if($do == 1){
		foreach my $k(keys %seq){
			$nucl = substr $seq{$k}, $i, 1;
			$finalseq{$k} = $finalseq{$k}.$nucl;
		}
	}
	
}

foreach my $k(keys %finalseq){
	print $fn $k."\n".$finalseq{$k}."\n";
}

##Closing the opened file variables
close $fn;
close FASTA;


print "SNP calling has been completed!\n";
exit;


