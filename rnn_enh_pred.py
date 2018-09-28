from __future__ import print_function
import tensorflow as tf
from tensorflow.contrib import rnn
import numpy as np
import dataset
import sys

if len(sys.argv)<2:
    print("python3 rnn_enh_pred.py pos_pred_path neg_pred_path")
    quit()

#Load the configuration file to get basic paramters
data = dataset.read_pred_sets(sys.argv[1], sys.argv[2])
print(len(data.pred.labels))
sess = tf.Session()
saver = tf.train.import_meta_graph('rnn_model/rnn.enhancer.meta')
saver.restore(sess, tf.train.latest_checkpoint('rnn_model/'))
graph = tf.get_default_graph()

#for op in graph.get_operations():
#        print(op.name)
y_pred = graph.get_tensor_by_name("y_pred:0")
x= graph.get_tensor_by_name("x:0")
y_true = graph.get_tensor_by_name("y_true:0")
feed_dict_testing = {x: data.pred.seqs, y_true: data.pred.labels}
result=sess.run(y_pred, feed_dict=feed_dict_testing)

# Output the predictions
with open(sys.argv[3],'w') as of:
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
        of.write(str(data.pred.labels[i][1])+"\t"+str(row[0])+"\t"+str(row[1])+"\t"+str(c)+"\n")
        i+=1

