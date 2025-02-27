import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
import pickle
import joblib
from skl2onnx import convert_sklearn
from skl2onnx.common.data_types import FloatTensorType

# merging two csv files

df = pd.read_csv('lib/nlp_materials/Language Detection.csv')
 
print(df.index) 

# Extract the text and language columns
X = df['Text']
y = df['Language']


# Vectorize the text data
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(X)

# Split into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a Naive Bayes classifier
model = MultinomialNB()
model.fit(X_train, y_train)

# Evaluate on the test set
accuracy = model.score(X_test, y_test)
print("Accuracy:", accuracy)


# Export model 
with open('RFmodel.pkl', 'wb') as f:
    pickle.dump(model, f) 

# Export vectorizer    
with open('vectorizer.pkl', 'wb') as f:
    pickle.dump(vectorizer, f)

initial_types = [('float_input', FloatTensorType([None, X.shape[1]]))]

converted_model = convert_sklearn(model=model, initial_types=initial_types)
with open("lib/nlp_materials/model.onnx", "wb") as f:
    f.write(converted_model.SerializeToString())


# Serialize with joblib
joblib.dump(model, 'model.joblib')

with open('RFmodel.pkl', 'rb') as f:
   openmodel = pickle.load(f)

with open('vectorizer.pkl', 'rb') as f:
   openvectorizer = pickle.load(f)

new_text = ["Ich Habe un Frage", "آپ کيا کررہے ہو", "Hello how are you"] 

new_vectors = openvectorizer.transform(new_text)
predictions = openmodel.predict(new_vectors)


for text, pred in zip(new_text, predictions):
    print(f"{text} is predicted to be in {pred} language")