# enhancer-prediction
Multiple machine learning and deep learning models for kmer-based enhancer prediction. Usage of each program (excluding wrapper scripts) can be displayed by typing a command line without any option.

## Dependency
python3, g++, perl, tensorflow, sklearn, numpy, pandas

## List of programs
### Data preprocessing
1) **mask_seq.pl**
Mask DNA sequences - repeat sequences by 'N's, and other masked sequences by 'X's.
2) **paral_mask_seq_hepg2.pl**
Mask Hepg2 strong enhancer sequences from the human genome.
3) **paral_mask_seq_gm12878.pl**
Mask gm12878 strong enhancer sequences from the human genome.
4) **divide_200bp.pl**
Divide enhancer chromosomal positions to 210bp length windows.
5) **retrieve_sequence.pl**
Retrieve DNA sequence given chromosomal positions.
6) **filter_seq.pl**
Filter fastq sequence by removing those with any masked nucleotide, and generate sequence features including CG content.
7) **scan_sel_new.cc**
Randomly select n-fold DNA sequences from the genome by matching sequence lengths, repeat contents and CG contents in a feature file.
8) **get_kmer_dict.pl**
Generate kmer dictionaries including kmers, fold-changes and p-values by comparing between positive and negative sequences.
9) **code_seq.pl**
Transform DNA sequences to kmer features for deep learning based on kmer dictionaries of a cell type.
10) **make_all_fea.pl**
Wrapper for implementing code_seq.pl
11) **divide_feature_unbalance.pl**
Divide deep learning positive and negative (size could be several folds) features into train and testing sets according to a ratio.
12) **make_svm_fea.pl**
Convert deep learning features to SVM features (flattened)
13) **make_all_svm_fea.pl**
Wrapper for implementing make_svm_fea.pl
14) **random_selection.py**
Randomly select a pre-defined proportion of rows from a file 

### Enhancer prediction models
1) **rnn_enhancer.py**
Train an RNN model of enhancer identifier
2) **rnn_enh_pred.py**
Predict enhancers using an established RNN model
3) **multi_ml_enhancer.py**
Train enhancer identifiers of multiple machine learning models
4) **linearSVM_enhancer.py**
Train a linear SVM enhancer identifier and make predictions

### Post-analysis tools
1) **compute_roc.py**
Compute points of roc curves from a prediction file
2) **visualize.py**
Visualize roc curves

## Input data
Testing data can be download from http://www.bdxconsult.com/enhancer.html

### Data format
1) **RNN models**
Data files are tab delimited. Training and testing data should be in separate files and postive and negtive data should be in separate files. The features of each enhancer/control have four rows, each row corresponding to a specific length of Kmer (i.e. 5, 7, 9 or 11). In each row, the first column is the enhancer/control ID, while the subsequent columns contain the fold changes of Kmer at each nucleotide position of the 200bp window. For example,
```
enh_1    5mer_fold_change_nt1    5mer_fold_change_nt2    ...    5mer_fold_change_nt200
ehn_1    7mer_fold_change_nt2    7mer_fold_change_nt2    ...    7mer_fold_change_nt200
enh_1    9mer_fold_change_nt1    9mer_fold_change_nt2    ...    9mer_fold_change_nt200
ehn_1    11mer_fold_change_nt2    11mer_fold_change_nt2    ...    11mer_fold_change_nt200
enh_2    5mer_fold_change_nt1    5mer_fold_change_nt2    ...    5mer_fold_change_nt200
ehn_2    7mer_fold_change_nt2    7mer_fold_change_nt2    ...    7mer_fold_change_nt200
enh_2    9mer_fold_change_nt1    9mer_fold_change_nt2    ...    9mer_fold_change_nt200
ehn_2    11mer_fold_change_nt2    11mer_fold_change_nt2    ...    11mer_fold_change_nt200
```
2) **SVM and other ML models**
Data files are tab delimited. Training and testing data should be in separate files, but positive and negative data should be combined. The features of each enhancer/control have only one row.  The first column is 'class', where 0 indicates non-enhancer and 1 indicates enhancer. The subsequent columns contain the fold changes of Kmer at each nucleotide positon of the 200bp window in the order of 5mer, 7mer, 9mer and 11mer. For example,
```
1    5mer_fold_change_nt1    ...    5mer_fold_change_nt200    ...    7mer_fold_change_nt1    ...    7mer_fold_change_nt200    ...    9mer_fold_change_nt1    ...    9mer_fold_change_nt200    ...    11mer_fold_change_nt1    ...    11mer_fold_change_nt200
0    5mer_fold_change_nt1    ...    5mer_fold_change_nt200    ...    7mer_fold_change_nt1    ...    7mer_fold_change_nt200    ...    9mer_fold_change_nt1    ...    9mer_fold_change_nt200    ...    11mer_fold_change_nt1    ...    11mer_fold_change_nt200
```

## Usage
1) **Train an RNN model for predicting enhancers** 

First make sure tensorflow is installed and  activated
```
source ~/tensorflow/bin/activate
```
Use python3 to compile and run
```
python3 rnn_enhancer.py [-h] -t1 POS_TRN -t2 NEG_TRN -p1 POS_PRED -p2 NEG_PRED
                       -m MODEL [-r RATE] [-s STEPS] [-b BATCH_SIZE]
                       [-d DISPLAY_STEP]
```
Explanation of arguments:
```
  -h, --help            show this help message and exit
  -t1 POS_TRN, --pos_trn POS_TRN
                        positive training set
  -t2 NEG_TRN, --neg_trn NEG_TRN
                        negative training set
  -p1 POS_PRED, --pos_pred POS_PRED
                        positive prediction set
  -p2 NEG_PRED, --neg_pred NEG_PRED
                        negative prediction set
  -m MODEL, --model MODEL
                        path of saved model (folder + prefix)
  -r RATE, --rate RATE  learning rate
  -s STEPS, --steps STEPS
                        number of steps
  -b BATCH_SIZE, --batch_size BATCH_SIZE
                        batch size
  -d DISPLAY_STEP, --display_step DISPLAY_STEP
                        display_step
```
Command example:
```
python3 rnn_enhancer.py -t1 data/hepg2.rnn.trn.pos.fea -t2 data/hepg2.rnn.trn.neg.fea -p1 data/hepg2.rnn.pred.pos.fea -p2 data/hepg2.rnn.pred.neg.fea -m model/rnn.enh.pred -s 1000
```
2) **Predict enhancers using an established RNN model**

Use python3 to compile and run
```
python3 rnn_enh_pred.py [-h] -p1 POS_PRED -p2 NEG_PRED -m MODEL -o OUTFILE
```
Explanation of arguments:
```
  -h, --help            show this help message and exit
  -p1 POS_PRED, --pos_pred POS_PRED
                        positive prediction set
  -p2 NEG_PRED, --neg_pred NEG_PRED
                        negative prediction set
  -m MODEL, --model MODEL
                        path of pre-saved model ('.meta' file)
  -o OUTFILE, --outfile OUTFILE
                        output file
```
Command example:
```
python3 rnn_enh_pred.py -p1 data/hepg2.rnn.pred.pos.fea -p2 data/hepg2.rnn.pred.neg.fea -m model/rnn.enh.pred.meta -o rnn.enhancer.pred.outcome
```
Note that in the case that true enhancers are unknown in the prediction datasets, a postive and a negative input files are still needed.

3) **Train multiple ML models for enhancer prediction**
First make sure sklearn library is installed. Use python3 to compile and run
```
python3 multi_ml_enhancer.py trn_data pre_data clsfr_ID
```
The following are links between classifier IDs and names
```
0    Linear SVM
1    RBF SVM
2    Decision Tree
3    Random Forest
4    AdaBoost
5    Naive Bayes
```
Command example:
```
python3 multi_ml_enhancer.py data/hepg2.svm.trn.10pct.fea data/hepg2.svm.pred.fea 0
```
4) **Predict enhancers using linear SVM model**
Use python3 to compile and run
```
python3 linearSVM_enhancer.py trn_data pre_data output
```
Command example
```
python3 linearSVM_enhancer.py data/hepg2.svm.trn.10pct.fea data/hepg2.svm.pred.fea svm.enhancer.pred.outcome
```
## Outputs
### 1) rnn_enhancer.py
This program will display accuracy during running
```
Step 1, Minibatch Loss= 0.6862, Training Accuracy= 0.553
Step 200, Minibatch Loss= 0.5827, Training Accuracy= 0.691
Step 400, Minibatch Loss= 0.5193, Training Accuracy= 0.729
Step 600, Minibatch Loss= 0.4638, Training Accuracy= 0.793
Step 800, Minibatch Loss= 0.3368, Training Accuracy= 0.855
Step 1000, Minibatch Loss= 0.3348, Training Accuracy= 0.865
```
The program will also save the model in the user-specified path, including files
```
checkpoint
rnn.enh.pred.data-00000-of-00001
rnn.enh.pred.index
rnn.enh.pred.meta
```
### 2) rnn_enh_pred.py & linearSVM_enhancer.py
These two programs will output a text file in the format:
```
True_class Nonenhancer_prob Enhancer_prob Predicted_class
```
### 3) multi_ml_enhancer.py
This program will output the accuracy of the selected ML model
```
Classifier: Linear SVM, Accuracy: 0.908%
```
