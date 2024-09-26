namespace :export do
  desc "Export comments to CSV"
  task comments_to_csv: :environment do
    require 'csv'
    file_path = Rails.root.join('lib', 'python', 'initial_data.csv')

    CSV.open(file_path, 'wb') do |csv|
      csv << ['comment', 'sentiment']  # header row

      Comment.find_each do |comment|
        csv << [comment.body, comment.sentiment == 'positive' ? 1 : 0]
      end
    end

    puts "Comments exported to #{file_path}"
  end
end
