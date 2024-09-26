# lib/tasks/train_model.rake
require 'pycall/import'
include PyCall::Import


def train_and_save_model(comments, sentiments, model_path, vectorizer_path)
  sklearn_feature_extraction_text = PyCall.import_module('sklearn.feature_extraction.text')
  sklearn_naive_bayes = PyCall.import_module('sklearn.naive_bayes')
  joblib = PyCall.import_module('joblib')

  vectorizer = sklearn_feature_extraction_text.CountVectorizer.new
  x_data = vectorizer.fit_transform(comments)
  model = sklearn_naive_bayes.MultinomialNB.new
  model.fit(x_data, sentiments)
  joblib.dump(model, model_path)
  joblib.dump(vectorizer, vectorizer_path)
end


def retrain_from_csv(csv_path, model_path, vectorizer_path)
  pandas = PyCall.import_module('pandas')
  data = pandas.read_csv(csv_path)
  comments = data['comment']
  sentiments = data['sentiment']
  train_and_save_model(comments, sentiments, model_path, vectorizer_path)
  'Model retrained successfully'
end

namespace :train_model do
  desc "Retrain model from CSV"
  task :retrain_from_csv do
    begin
      csv_path = 'lib/python/initial_data.csv'
      model_path = 'lib/python/sentiment_model.joblib'
      vectorizer_path = 'lib/python/vectorizer.joblib'
      puts retrain_from_csv(csv_path, model_path, vectorizer_path)
    rescue PyCall::PyError => e
      puts "An error occurred: #{e}"
      puts e.backtrace
    end
  end
end
