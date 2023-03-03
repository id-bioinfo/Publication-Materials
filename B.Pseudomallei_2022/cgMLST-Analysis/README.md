# Introduction
In this section, the SNPs of the single-copy cgMLST genes of any given bacteria genomes will be generated from the input of the single-copy cgMLST gene fasta files.

Please be reminded Single Line fasta sequence file should be used when running with the perl scripts in this repository.

## Step 1:
After obtaining the single-copy cgMLST genes (in fasta file format), we will first translate the nucleotide sequences into amino acid sequences for amino acid based multiple sequence alignment.

Run the following script for each of the single-copy cgMLST fasta file located in the `fasta_sequence` directory.
```
perl S1_NucleotideToAminoAcidWithStopCodon.pl ./fasta_sequence/BPSEU00005.fasta_renamed
perl S1_NucleotideToAminoAcidWithStopCodon.pl ./fasta_sequence/BPSEU00010.fasta_renamed
perl S1_NucleotideToAminoAcidWithStopCodon.pl ./fasta_sequence/BPSEU00020.fasta_renamed
...
perl S1_NucleotideToAminoAcidWithStopCodon.pl ./fasta_sequence/BPSEU31890.fasta_renamed
```

Expected output amino acid fasta files are:

```
./fasta_sequence/BPSEU00005.fasta_renamed_protein
./fasta_sequence/BPSEU00010.fasta_renamed_protein
./fasta_sequence/BPSEU00020.fasta_renamed_protein
...
./fasta_sequence/BPSEU31890.fasta_renamed_protein
```

## Step 2:
After generating the amino acid fasta file, multiple sequence alignment will be performed using MAFFT v7.487.

To download MAFFT, please visit [MAFFT Homepage](https://mafft.cbrc.jp/alignment/software/).

Run the following command for performing the alignment using MAFFT for each of the amino acid fasta files of the single-copy cgMLST genes.
```
mafft --thread -1 --globalpair --maxiterate 1000 ./fasta_sequence/BPSEU00005.fasta_renamed_protein > ./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa
mafft --thread -1 --globalpair --maxiterate 1000 ./fasta_sequence/BPSEU00010.fasta_renamed_protein > ./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa
mafft --thread -1 --globalpair --maxiterate 1000 ./fasta_sequence/BPSEU00020.fasta_renamed_protein > ./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa
...
mafft --thread -1 --globalpair --maxiterate 1000 ./fasta_sequence/BPSEU31890.fasta_renamed_protein > ./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa
```

## Step 3:
After performing the multiple sequence alignment on the amino acid sequences using MAFFT, the aligned nucleotide sequences will be generated based on the aligned amino acid sequences.

Fistly, run the following command to generate single-lined fasta files for the MAFFT output files.

```
perl S2_MultipleLineToSingleLineFasta.pl ./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa
perl S2_MultipleLineToSingleLineFasta.pl ./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa
perl S2_MultipleLineToSingleLineFasta.pl ./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa
...
perl S2_MultipleLineToSingleLineFasta.pl ./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa
```

Expected output files are:
```
./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa.single
./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa.single
./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa.single
...
./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa.single
```

Then, run the following command to generate the aligned nucleotide sequences.

 ```
 perl S3_AlignedAminoAcidToNucleotideWithStopCodon.pl ./fasta_sequence/BPSEU00005.fasta_renamed ./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa.single
 perl S3_AlignedAminoAcidToNucleotideWithStopCodon.pl ./fasta_sequence/BPSEU00010.fasta_renamed ./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa.single
 perl S3_AlignedAminoAcidToNucleotideWithStopCodon.pl ./fasta_sequence/BPSEU00020.fasta_renamed ./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa.single
 ...
 perl S3_AlignedAminoAcidToNucleotideWithStopCodon.pl ./fasta_sequence/BPSEU31890.fasta_renamed ./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa.single
 ```

Expected output aligned nucleotide sequence files are:
```
./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa.single_nucleotide
./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa.single_nucleotide
./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa.single_nucleotide
...
./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa.single_nucleotide
```

## Step 4:

Then the aligned single-copy cgMLST genes nucleotide sequences will be concatinated into a single sequence.

Run the following command to concatinate the sequences.

```
perl S4_ConcatinatingSingleCopycgMLSTGenes.pl ./EXAMPLE/list.txt
```

The `list.txt` is a text file containing all the names of the aligned nucleotide fasta seqeunce files of the single-copy cgMLST genes.
In this example, the content of the `list.txt` is:
```
./fasta_sequence/BPSEU00005.fasta_renamed_protein.msa.single_nucleotide
./fasta_sequence/BPSEU00010.fasta_renamed_protein.msa.single_nucleotide
./fasta_sequence/BPSEU00020.fasta_renamed_protein.msa.single_nucleotide
...
./fasta_sequence/BPSEU31890.fasta_renamed_protein.msa.single_nucleotide
```
Expected output file containing the concatinated sequences are:

`./fasta_sequence/list.txt.ConcatinatedSequence`

## Step 5:
Finally, the SNP calling can be performed by running the following command.

```
perl S5_GetSNPSite.pl ./fasta_sequence/list.txt.ConcatinatedSequence
```
