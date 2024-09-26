# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# db/seeds.rb
Post.create(title: 'Sample Post', body: 'This is a sample post.')
Comment.create(post_id: 1, body: 'I love this!', sentiment: 'positive')
Comment.create(post_id: 1, body: 'This is great!', sentiment: 'positive')
Comment.create(post_id: 1, body: 'I hate this.', sentiment: 'negative')
Comment.create(post_id: 1, body: 'This is terrible.', sentiment: 'negative')
