import joblib
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB

def train_and_save_model(comments, sentiments, model_path, vectorizer_path):
    vectorizer = CountVectorizer()
    X = vectorizer.fit_transform(comments)
    model = MultinomialNB()
    model.fit(X, sentiments)
    joblib.dump(model, model_path)
    joblib.dump(vectorizer, vectorizer_path)

def load_model(model_path, vectorizer_path):
    model = joblib.load(model_path)
    vectorizer = joblib.load(vectorizer_path)
    return model, vectorizer

def predict(text, model, vectorizer):
    X = vectorizer.transform([text])
    prediction = model.predict(X)[0]
    return 'positive' if prediction == 1 else 'negative'

def retrain_from_csv(csv_path, model_path, vectorizer_path):
    data = pd.read_csv(csv_path)
    comments = data['comment']
    sentiments = data['sentiment']
    train_and_save_model(comments, sentiments, model_path, vectorizer_path)
    return 'Model retrained successfully'
