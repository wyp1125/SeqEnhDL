import tensorflow as tf
import keras
from keras import layers
from keras.callbacks import ModelCheckpoint
from keras.models import model_from_json,load_model
import numpy as np
import argparse
from sklearn.utils import shuffle
from sklearn.metrics import roc_curve
from sklearn.metrics import auc
parser = argparse.ArgumentParser(description='Process input files and parameters.')
parser.add_argument('-x1', '--trnx', type=str, required=True, help="training features")
parser.add_argument('-y1', '--trny', type=str, required=True, help="training outcomes")
parser.add_argument('-x2', '--tstx', type=str, required=True, help="testing features")
parser.add_argument('-y2', '--tsty', type=str, required=True, help="testing outcomes")
parser.add_argument('-r', '--rate', type=float, required=False, help="learning rate")
parser.add_argument('-c', '--epochs', type=int, required=False, help="number of epochs")
parser.add_argument('-b', '--batch_size', type=int, required=False, help="batch size")
parser.add_argument('-m', '--model',type=str, required=False, help="save best model to file")
parser.add_argument('-l', '--log', type=str, required=False, help="log file for accuracy of best model")
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
saved_model = ""
if args.model:
    saved_model=args.model
log_file = ""
if args.log:
    if saved_model=="":
        print("saved_model must be specified when using this option")
        quit()
    log_file=args.log

Xall=np.loadtxt(args.trnx)
Yall=np.loadtxt(args.trny)
Xall,Yall=shuffle(Xall,Yall)
Xall_len=Xall.shape[0]
Xtrn_len=int(Xall_len*0.7+0.5)
Xval_len=Xall_len-Xtrn_len
Xtrn=Xall[:Xtrn_len,]
Ytrn=Yall[:Xtrn_len,]
Xval=Xall[Xtrn_len:,]
Yval=Yall[Xtrn_len:,]
Xtrn=Xtrn.reshape((Xtrn_len,200,4))
Xval=Xval.reshape((Xval_len,200,4))
ncls=Ytrn.shape[1]

Xtst=np.loadtxt(args.tstx)
Xtst_len=Xtst.shape[0]
Xtst=Xtst.reshape((Xtst_len,200,4))
Ytst=np.loadtxt(args.tsty)

input_shape=(200,4)
model = keras.Sequential()
model.add(layers.Dense(400, activation='relu', input_shape=input_shape))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(400, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Flatten())
model.add(layers.Dense(ncls, activation='softmax'))
model.compile(optimizer=tf.optimizers.Adam(learning_rate),
              loss='categorical_crossentropy',
              metrics=['accuracy'])
if saved_model=="":
    model.fit(Xtrn, Ytrn, validation_data=(Xval,Yval), epochs=training_epochs, verbose=1, batch_size=batch_size)
    score=model.evaluate(Xtst, Ytst, verbose=1)
    print("%s: %.3f" % (model.metrics_names[1], score[1]))
else:
    checkpoint = ModelCheckpoint(filepath=saved_model+'.h5', verbose=1, monitor='val_loss',save_best_only=True,save_weights_only=True)  
    model.fit(Xtrn, Ytrn, validation_data=(Xval,Yval), epochs=training_epochs, verbose=1, callbacks=[checkpoint], batch_size=batch_size)
    model_json=model.to_json()
    with open(saved_model+'.json',"w") as of:
        of.write(model_json)
        of.close()
    if log_file!="":
        with open(log_file,"w") as of:
           json_file=open(saved_model+'.json','r')
           loaded_model_json=json_file.read()
           json_file.close() 
           loaded_model=model_from_json(loaded_model_json)
           loaded_model.load_weights(saved_model+'.h5')
           loaded_model.compile(optimizer=tf.optimizers.Adam(learning_rate),
                                loss='categorical_crossentropy',
                                metrics=['accuracy'])
           score=loaded_model.evaluate(Xtst, Ytst, verbose=1)
           of.write("%s: %.3f\n" % (loaded_model.metrics_names[1], score[1]))
           Ypred=loaded_model.predict(Xtst).ravel()
           fpr, tpr, threshold = roc_curve(Ytst.ravel(), Ypred)
           auc_dnn = auc(fpr,tpr)
           of.write("auc: %.3f\n" % (auc_dnn))

