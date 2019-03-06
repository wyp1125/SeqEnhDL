import tensorflow as tf
from tensorflow.keras import layers
from tensorflow.keras.callbacks import TensorBoard
from time import time

import numpy as np
import argparse
parser = argparse.ArgumentParser(description='Process input files and parameters.')
parser.add_argument('-x1', '--trnx', type=str, required=True, help="training features")
parser.add_argument('-y1', '--trny', type=str, required=True, help="training outcomes")
parser.add_argument('-x2', '--tstx', type=str, required=True, help="testing features")
parser.add_argument('-y2', '--tsty', type=str, required=True, help="testing outcomes")
parser.add_argument('-r', '--rate', type=float, required=False, help="learning rate")
parser.add_argument('-c', '--epochs', type=int, required=False, help="number of epochs")
parser.add_argument('-b', '--batch_size', type=int, required=False, help="batch size")
parser.add_argument('-l', '--log', type=str, required=False, help="log file")
args = parser.parse_args()
learning_rate = 0.001
if args.rate:
    learning_rate=args.rate
training_epochs = 10
if args.epochs:
    training_epochs=args.epochs
batch_size = 512
if args.batch_size:
    batch_size=args.batch_size
use_tb=False
log_dir=""
if args.log:
    use_tb=True
    log_dir=args.log

Xtrn=np.loadtxt(args.trnx)
Xtrn_len=Xtrn.shape[0]
Xtrn=Xtrn.reshape((Xtrn_len,200,4))

Ytrn=np.loadtxt(args.trny)
ncls=Ytrn.shape[1]

Xtst=np.loadtxt(args.tstx)
Xtst_len=Xtst.shape[0]
Xtst=Xtst.reshape((Xtst_len,200,4))

Ytst=np.loadtxt(args.tsty)

model = tf.keras.Sequential()
model.add(layers.Bidirectional(layers.LSTM(128)))
model.add(layers.Dense(ncls, activation='softmax'))
model.compile(optimizer=tf.train.AdamOptimizer(learning_rate),
              loss='categorical_crossentropy',
              metrics=['accuracy'])
if use_tb:
    tensorboard = TensorBoard(log_dir=log_dir)
    model.fit(Xtrn, Ytrn, validation_data=(Xtst,Ytst), epochs=training_epochs, batch_size=batch_size, callbacks=[tensorboard])
else:
    model.fit(Xtrn, Ytrn, validation_data=(Xtst,Ytst), epochs=training_epochs, batch_size=batch_size)


