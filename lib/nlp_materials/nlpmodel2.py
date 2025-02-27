import pathlib
import tensorflow as tf
import pandas as pd
import re
import string
from sklearn.model_selection import train_test_split
from keras_preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences

# Load the data from the CSV file
data = pd.read_csv('lib/nlp_materials/Language Detection.csv')

# Preprocess the data
def preprocess_text(text):
    text = text.lower()
    text = re.sub(r'[^a-zA-Z]', ' ', text)
    text = ' '.join(text.split())
    return text

data['Text'] = data['Text'].apply(preprocess_text)

# Map language labels to integers
unique_labels = data['Language'].unique()
label_mapping = {label: idx for idx, label in enumerate(unique_labels)}
data['Language'] = data['Language'].map(label_mapping)

# Split the data into input (text) and output (language)
X = data['Text']
y = data['Language']

# Tokenize the text data
tokenizer = Tokenizer()
tokenizer.fit_on_texts(X)
X = tokenizer.texts_to_sequences(X)
X = pad_sequences(X, maxlen=100)  # Pad or truncate sequences to a fixed length

# One-hot encode the output labels
num_classes = len(set(y))
y = tf.keras.utils.to_categorical(y, num_classes=num_classes)

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Define the model architecture
model = tf.keras.Sequential([
    tf.keras.layers.Embedding(input_dim=len(tokenizer.word_index) + 1, output_dim=128, input_length=100),
    tf.keras.layers.LSTM(64),
    tf.keras.layers.Dense(num_classes, activation='softmax')
])

# Compile the model
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# Train the model
model.fit(X_train, y_train, epochs=10, batch_size=32, validation_data=(X_test, y_test))

def detect_language(text):
    text = preprocess_text(text)
    sequence = tokenizer.texts_to_sequences([text])
    sequence = pad_sequences(sequence, maxlen=100)
    prediction = model.predict(sequence)[0]
    language_index = prediction.argmax()
    language_labels = list(label_mapping.keys())
    language = language_labels[language_index]
    return language

# Example usage
sentence = "Ich Habe un Fraige"
language = detect_language(sentence)
print(f"The language of the sentence is: {language}")

# Convert the model to TFLite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.allow_custom_ops = True
converter.experimental_new_converter = True
converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS, tf.lite.OpsSet.SELECT_TF_OPS]
tflite_model = converter.convert()

# Save the TFLite model to a file
tflite_model_path = pathlib.Path("lib/nlp_materials/language_detection_model.tflite")
tflite_model_path.write_bytes(tflite_model)