# enhancer-prediction
Multiple machine learning and deep learning models for sequence-based enhancer prediction
1) mask_seq.pl
Mask DNA sequences: repeat sequences by 'N's, and other masked sequences by 'X's.
2) paral_mask_seq_hepg2.pl
Mask Hepg2 strong enhancer sequences from the human genome.
3) paral_mask_seq_gm12878.pl
Mask gm12878 strong enhancer sequences from the human genome.
4) divide_200bp.pl
Divide enhancer chromosomal positions to 210bp length windows.
5) retrieve_sequence.pl
Retrieve DNA sequence given chromosomal positions.
6) filter_seq.pl
Filter fastq sequence by removing those with any masked nucleotide, and generate sequence features including CG content.
7) scan_sel_new.cc
Randomly select n-fold DNA sequences from the genome by matching sequence lengths, repeat contents and CG contents in a feature file.

