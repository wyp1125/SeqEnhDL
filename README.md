# SeqEnhDL
Deep learning and SVM models for kmer-based enhancer classification. Utility programs for data processing are also provided. Usage of each program (excluding wrapper scripts) can be displayed by typing a command line without any option.

## Dependency
python3, g++, perl, tensorflow, sklearn, numpy, pandas

## List of programs
### Data preprocessing
1) **mask_seq.pl**
Mask regions of chromosomal sequences: repeat sequences by 'N's, and other masked sequences by 'X's.
2) **paral_mask_seq_*.pl**
Wrapper to run mask_seq.pl.
3) **divide_200bp.pl**
Divide enhancer chromosomal positions to 210bp windows.
4) **retrieve_sequence.pl**
Retrieve DNA sequence given chromosomal positions.
5) **filter_seq.pl**
Filter out fastq sequence overlapped with any masked nucleotide, and generate GC content information for the kept sequences.
6) **scan_sel_new.cc**
Randomly select n-fold DNA sequences from the genome by matching given sequence lengths, repeat contents and CG contents in a feature file.
7) **paral_scan_sel_new_*.pl**
Wrapper to run scan_sel_new.
8) **get_kmer_dict.pl**
Generate kmer dictionaries between kmers and fold-changes by comparing between positive and control sequences.
9) **paral_get_kmer_dict.pl**
Wrapper to run get_kmer_dict.pl.
10) **make_fasta_cv.py**
Make cross-validation datasets for a pair of positive and negative fasta files. Note that headers and their corresponding sequences are placed in the same lines in the output files.
11) **code_seq.pl**
Transform DNA sequences (flattened fasta files) to kmer fold changes for deep learning, based on provided kmer dictionaries.
12) **paral_code_seq*.pl**
Wrapper to run code_seq.pl.
13) **random_selection.py**
Randomly select a pre-defined proportion of samples from feature files.

### Enhancer classifiers
1) **SeqEnhMLP.py**
Train and test a multi-layer perceptron model of enhancer classifier.
2) **SeqEnhCNN.py**
Train and test a CNN model of enhancer classifier.
3) **SeqEnhRNN.py**
Train and test an RNN model of enhancer classifier.
4) **multi_ml_enhancer.py**
Train and test an enhancer classifier using a conventional machine learning model.


## Input data
Testing data can be download from http://www.bdxconsult.com/SeqEnhDL.

### Data format
Positive and negative features should be stored in the same files and training and testing data should be separated. Class labels should be provided as dummy variables in separate files.
Format for features
```
5mer_fc_nt1    7mer_fc_nt1    9mer_fc_nt1    11mer_fc_nt1    ...    5mer_fc_nt200    7mer_fc_nt200    9mer_fc_nt200    11mer_fc_nt200
5mer_fc_nt1    7mer_fc_nt1    9mer_fc_nt1    11mer_fc_nt1    ...    5mer_fc_nt200    7mer_fc_nt200    9mer_fc_nt200    11mer_fc_nt200
```
Format for class labels
```
0    1
1    0
```

## Usage
To know how to run each enhancer classifier program, users can just type "python3 program_name". For each program, four input files are required, including training features (trn*X), training labels (trn*Y), testing features (tst*X), testing lables (tst*Y). Users need to make sure these files are provided in the correct order or with right foregoing arguments.

## Output
Accuracy (and AUC) will be printed after an enhancer classifier is successfully trained and tested.
