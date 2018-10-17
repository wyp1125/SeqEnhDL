# enhancer-prediction
Multiple machine learning and deep learning models for kmer-based enhancer prediction. The package includes the following scripts:

Data processing tools:
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
8) get_kmer_dict.pl
Generate kmer dictionaries including kmers, fold-changes and p-values by comparing between positive and negative sequences.
9) code_seq.pl
Transform DNA sequences to kmer features for deep learning based on kmer dictionaries of a cell type.
10) make_all_fea.pl
Wrapper for implementing code_seq.pl
11) divide_feature_unbalance.pl
Divide deep learning positive and negative (size could be several folds) features into train and testing sets according to a ratio.
12) make_svm_fea.pl
Convert deep learning features to SVM features (flattened)
13) make_all_svm_fea.pl
Wrapper for implementing make_svm_fea.pl
14) random_selection.py
Randomly select a pre-defined proportion of rows from a file 

Enhancer prediction models
1) rnn_enhancer.py
Train an RNN model of enhancer identifier
2) rnn_enh_pred.py
Predict enhancers using an established RNN model
3) multi_ml_enhancer.py
Train enhancer identifiers of multiple machine learning models
4) linearSVM_enhancer.py
Train a linear SVM enhancer identifier and make predictions

Post-analysis tools
1) compute_roc.py
Compute points of roc curves from a prediction file
2) visualize.py
Visualize roc curves

Testing data
Testing data can be download from http://www.bdxconsult.com/enhancer.html

Input data format
1) RNN models
Data files are tab delimited. Training and testing data should be in separate files and postive and negtive data should be in separate files. The features of each enhancer/control have four rows, each row corresponding to a specific length of Kmer (i.e. 5, 7, 9 or 11). In each row, the first column is the enhancer/control ID, while the subsequent columns contain the fold changes of Kmer at each nucleotide position of the 200bp window. For example,
<code>
enh_1    5mer_fold_change_nt1    5mer_fold_change_nt2    ...    5mer_fold_chang_nt200

ehn_1    7mer_fold_change_nt2    7mer_fold_change_nt2    ...    7mer_fold_change_nt200

enh_1    9mer_fold_change_nt1    9mer_fold_change_nt2    ...    9mer_fold_chang_nt200

ehn_1    11mer_fold_change_nt2    11mer_fold_change_nt2    ...    11mer_fold_change_nt200

enh_2    5mer_fold_change_nt1    5mer_fold_change_nt2    ...    5mer_fold_chang_nt200

ehn_2    7mer_fold_change_nt2    7mer_fold_change_nt2    ...    7mer_fold_change_nt200

enh_2    9mer_fold_change_nt1    9mer_fold_change_nt2    ...    9mer_fold_chang_nt200

ehn_2    11mer_fold_change_nt2    11mer_fold_change_nt2    ...    11mer_fold_change_nt200
</code>
2) SVM and other ML models
Data files are tab delimited. Training and testing data should be in separate files, but positive and negative data should be combined. The features of each enhancer/control have only one row.  The first column is 'class', where 0 indicates non-enhancer and 1 indicates enhancer. The subsequent columns contain the fold changes of Kmer at each nucleotide positon of the 200bp window in the order of 5mer, 7mer, 9mer and 11mer.

Usage
1) Train an RNN model for enhancer prediction (first make sure tensorflow is activated)

2) Predict enhancers using an established RNN model

3) Train multiple ML models for enhancer prediction

4) Predict enhancers using linear SVM model
