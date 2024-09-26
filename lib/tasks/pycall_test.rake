require 'pycall'


namespace :pycall do
  desc "Test PyCall with joblib"
  task :test_joblib => :environment do
    Joblib = PyCall.import_module("joblib")
    puts "Joblib version: #{Joblib.__version__}"
  end
end
