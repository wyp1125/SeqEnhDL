import os
from sklearn.utils import shuffle
import numpy as np
def load_train(pos_path,neg_path):
    allseqs=[]
    labels=[]
    seq_names=[]
    lines=open(pos_path,"r")
    i=0
    seq=[]
    cls=[]
    for eachline in lines:
        word=eachline.strip().split('\t')
        temp=[float(x) for x in word[1:]]
        seq.append(temp)
        i=i+1
        if i%4==0:
            seq=np.array(seq).T
            allseqs.append(seq.tolist())
            labels.append([1,0])
            seq_names.append(word[0])
            cls.append("Enh")
            seq=[]
    lines=open(neg_path,"r")
    i=0
    seq=[]
    for eachline in lines:
        word=eachline.strip().split("\t")
        temp=[float(x) for x in word[1:]]
        seq.append(temp)
        i=i+1
        if i%4==0:
            seq=np.array(seq).T
            allseqs.append(seq.tolist())
            labels.append([0,1])
            seq_names.append(word[0])
            cls.append("Ctl")
            seq=[]
    allseqs=np.array(allseqs)
    labels=np.array(labels)
    seq_names=np.array(seq_names)
    cls=np.array(cls) 
    return allseqs, labels, seq_names, cls

class DataSet(object):
  def __init__(self, seqs, labels, seq_names, cls):
    self._num_examples = seqs.shape[0]
    self._seqs = seqs
    self._labels = labels
    self._seq_names = seq_names
    self._cls = cls
    self._epochs_done = 0
    self._index_in_epoch = 0

  @property
  def seqs(self):
    return self._seqs

  @property
  def labels(self):
    return self._labels

  @property
  def seq_names(self):
    return self._seq_names

  @property
  def cls(self):
    return self._cls

  @property
  def num_examples(self):
    return self._num_examples

  @property
  def epochs_done(self):
    return self._epochs_done

  def next_batch(self, batch_size):
    start = self._index_in_epoch
    self._index_in_epoch += batch_size
    if self._index_in_epoch > self._num_examples:
      self._epochs_done += 1
      start = 0
      self._index_in_epoch = batch_size
      assert batch_size <= self._num_examples
    end = self._index_in_epoch
    return self._seqs[start:end], self._labels[start:end], self._seq_names[start:end], self._cls[start:end]

def read_train_sets(pos_path, neg_path, pos_path_pred, neg_path_pred):
  class DataSets(object):
    pass
  data_sets = DataSets()

  train_seqs, train_labels, train_seq_names, train_cls = load_train(pos_path, neg_path)
  validation_seqs, validation_labels, validation_seq_names, validation_cls = load_train(pos_path_pred, neg_path_pred)
  train_seqs, train_labels, train_seq_names, train_cls = shuffle(train_seqs, train_labels, train_seq_names, train_cls)
  validation_seqs, validation_labels, validation_seq_names, validation_cls = shuffle(validation_seqs, validation_labels, validation_seq_names, validation_cls)  

  data_sets.train = DataSet(train_seqs, train_labels, train_seq_names, train_cls)
  data_sets.valid = DataSet(validation_seqs, validation_labels, validation_seq_names, validation_cls)

  return data_sets

def read_pred_sets(pos_path_pred, neg_path_pred):
  class DataSets(object):
    pass
  data_sets = DataSets()

  validation_seqs, validation_labels, validation_seq_names, validation_cls = load_train(pos_path_pred, neg_path_pred)
  validation_seqs, validation_labels, validation_seq_names, validation_cls = shuffle(validation_seqs, validation_labels, validation_seq_names, validation_cls)

  data_sets.pred = DataSet(validation_seqs, validation_labels, validation_seq_names, validation_cls)
  return data_sets

