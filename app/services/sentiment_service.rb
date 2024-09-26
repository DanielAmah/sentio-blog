# app/services/sentiment_service.rb
require 'pycall/import'
include PyCall::Import

sys = PyCall.import_module('sys')
sys.path.append(File.join(Rails.root, 'lib', 'python'))

class SentimentService
  joblib = PyCall.import_module('joblib')
  MODEL_PATH = Rails.root.join('lib', 'python', 'sentiment_model.joblib').to_s
  VECTORIZER_PATH = Rails.root.join('lib', 'python', 'vectorizer.joblib').to_s
  CSV_PATH = Rails.root.join('lib', 'python', 'initial_data.csv').to_s

  def self.analyze(text)
    train_model = PyCall.import_module('train_model')
    model, vectorizer = train_model.load_model(MODEL_PATH, VECTORIZER_PATH)
    train_model.predict(text, model, vectorizer)
  end

  def self.retrain_from_csv
    train_model.retrain_from_csv(CSV_PATH, MODEL_PATH, VECTORIZER_PATH)
  end
end
