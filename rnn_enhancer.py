from __future__ import print_function
import tensorflow as tf
from tensorflow.contrib import rnn
import numpy as np
import dataset
import sys

if len(sys.argv)<3:
    print("pos_path neg_path pos_path_pred neg_path_pred")
    quit()
data = dataset.read_train_sets(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
print(len(data.train.labels))
print(len(data.valid.labels))

# Training Parameters
learning_rate = 0.001
training_steps = 3000
batch_size = 512
display_step = 200

# Network Parameters
num_input = 4 # number of features at each nt
timesteps = 200 # timesteps
num_hidden = 128 # hidden layer num of features
num_classes = 2 # total classes (enhancer or random sequence)

# tf Graph input
x = tf.placeholder("float", [None, timesteps, num_input], name='x')
y_true = tf.placeholder("float", [None, num_classes], name='y_true')
y_true_cls = tf.argmax(y_true, dimension=1)

# Define weights
weights = {
    # Hidden layer weights => 2*n_hidden because of forward + backward cells
    'out': tf.Variable(tf.random_normal([2*num_hidden, num_classes]))
}
biases = {
    'out': tf.Variable(tf.random_normal([num_classes]))
}

def BiRNN(x, weights, biases):

    # Prepare data shape to match `rnn` function requirements
    # Current data input shape: (batch_size, timesteps, n_input)
    # Required shape: 'timesteps' tensors list of shape (batch_size, num_input)

    # Unstack to get a list of 'timesteps' tensors of shape (batch_size, num_input)
    x = tf.unstack(x, timesteps, 1)

    # Define lstm cells with tensorflow
    # Forward direction cell
    lstm_fw_cell = rnn.BasicLSTMCell(num_hidden, forget_bias=1.0)
    # Backward direction cell
    lstm_bw_cell = rnn.BasicLSTMCell(num_hidden, forget_bias=1.0)

    # Get lstm cell output
    try:
        outputs, _, _ = rnn.static_bidirectional_rnn(lstm_fw_cell, lstm_bw_cell, x,
                                              dtype=tf.float32)
    except Exception: # Old TensorFlow version only returns outputs not states
        outputs = rnn.static_bidirectional_rnn(lstm_fw_cell, lstm_bw_cell, x,
                                        dtype=tf.float32)

    # Linear activation, using rnn inner loop last output
    return tf.matmul(outputs[-1], weights['out']) + biases['out']

nn_model=BiRNN(x, weights, biases)
y_pred=tf.nn.softmax(nn_model, name='y_pred')
y_pred_cls=tf.argmax(y_pred, dimension=1)
cross_entropy = tf.nn.softmax_cross_entropy_with_logits(logits=nn_model,labels=y_true)
cost = tf.reduce_mean(cross_entropy)
optimizer = tf.train.GradientDescentOptimizer(learning_rate=learning_rate).minimize(cost)
correct_prediction = tf.equal(y_pred_cls, y_true_cls)
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

# Initialize the variables (i.e. assign their default value)
init = tf.global_variables_initializer()

# Start training
saver = tf.train.Saver()
with tf.Session() as sess:

    # Run the initializer
    sess.run(init)
    for step in range(1, training_steps+1):
        x_batch, y_true_batch, _, cls_batch = data.train.next_batch(batch_size)
        x_valid_batch, y_valid_batch, _, valid_cls_batch = data.valid.next_batch(batch_size)
       
        feed_dict_tr = {x: x_batch,
                           y_true: y_true_batch}
        feed_dict_val = {x: x_valid_batch,
                              y_true: y_valid_batch}

        sess.run(optimizer, feed_dict=feed_dict_tr)

        if step % display_step == 0 or step == 1:
            # Calculate batch loss and accuracy
            loss, acc = sess.run([cost, accuracy], feed_dict=feed_dict_val)
            print("Step " + str(step) + ", Minibatch Loss= " + \
                  "{:.4f}".format(loss) + ", Training Accuracy= " + \
                  "{:.3f}".format(acc))
    saver.save(sess, "/home/yupeng/bdx/enhancer/models/rnn_model/rnn.enhancer") 

