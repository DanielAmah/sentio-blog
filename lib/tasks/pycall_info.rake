# lib/tasks/pycall_info.rake
require 'pycall/import'
include PyCall::Import

namespace :pycall do
  desc "Print Python environment information"
  task :info => :environment do
    pyimport :sys
    puts "Python version: #{sys.version}"
    puts "Python executable: #{sys.executable}"
    puts "Python paths:"
    sys.path.each { |path| puts "  - #{path}" }
  end
end
