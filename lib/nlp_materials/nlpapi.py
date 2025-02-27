import logging
from flask import Flask, request, jsonify
import pickle

app = Flask(__name__)

logging.basicConfig(level=logging.DEBUG) 


# Load exported model and vectorizer
with open('model.pkl', 'rb') as f:
   model = pickle.load(f)

with open('vectorizer.pkl', 'rb') as f:
   vectorizer = pickle.load(f)
   
@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/predict", methods=['GET','POST']) 
def predict():
   if request.method == 'POST':
      data = request.get_json()
      text = data['text']
      vectorized = vectorizer.transform([text])
      prediction = model.predict(vectorized)[0]
      return jsonify({
         'code':200,
         'status':'OK',
         'language': prediction
         })
   
if __name__ == "__main__":
   app.run(host='0.0.0.0',port=5000, debug=True)


