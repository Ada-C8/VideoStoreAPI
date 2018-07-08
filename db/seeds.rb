# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MOVIE_FILE = Rails.root.join('db', 'seeds', 'movies.json')

movies = JSON.parse(File.read(MOVIE_FILE))
#
# PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'products.csv')
# puts "Loading raw product data from #{PRODUCT_FILE}"

movies.each do |movie|
  Movie.create!(movie)
end


CUSTOMER_FILE = Rails.root.join('db', 'seeds', 'customers.json')

customers = JSON.parse(File.read(CUSTOMER_FILE))

customers.each do |customer|
  Customer.create!(customer)
end
