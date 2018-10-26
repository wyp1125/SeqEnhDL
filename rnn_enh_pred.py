from __future__ import print_function
import tensorflow as tf
from tensorflow.contrib import rnn
import numpy as np
import dataset
import os,sys
import argparse

parser = argparse.ArgumentParser(description='Process input files and parameters.')
parser.add_argument('-p1', '--pos_pred', type=str, required=True, help="positive prediction set")
parser.add_argument('-p2', '--neg_pred', type=str, required=True, help="negative prediction set")
parser.add_argument('-m', '--model', type=str, required=True, help="path of saved model ('.meta' file)")
parser.add_argument('-o', '--outfile', type=str, required=True, help="output file")
args = parser.parse_args()

#Load the configuration file to get basic paramters
data = dataset.read_pred_sets(args.pos_pred, args.neg_pred)
print(len(data.pred.labels))
sess = tf.Session()
saver = tf.train.import_meta_graph(args.model)
modeldir=os.path.dirname(args.model)+'/'
#saver.restore(sess, tf.train.latest_checkpoint("model/"))
saver.restore(sess, tf.train.latest_checkpoint(modeldir))
graph = tf.get_default_graph()

#for op in graph.get_operations():
#        print(op.name)
y_pred = graph.get_tensor_by_name("y_pred:0")
x= graph.get_tensor_by_name("x:0")
y_true = graph.get_tensor_by_name("y_true:0")
feed_dict_testing = {x: data.pred.seqs, y_true: data.pred.labels}
result=sess.run(y_pred, feed_dict=feed_dict_testing)

# Output the predictions
with open(args.outfile,'w') as of:
    i=0
    for row in result:
        c=0
        max_p=0
        j=0
        for p in row:
            if p>max_p:
                max_p=p
                c=j
            j+=1
        of.write(str(data.pred.seq_names[i])+"\t"+str(data.pred.labels[i][0])+"\t"+str(row[0])+"\t"+str(row[1])+"\t"+str(1-c)+"\n")
        i+=1

