# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
movies = JSON.parse(File.read('db/seeds/movies.json'))
puts movies
puts movies.class



movies.each do |movie|
  movie["available_inventory"] = movie["inventory"]
end

movies.each do |movie|
  Movie.create!(movie)
end


json = JSON.parse(File.read('db/seeds/customers.json'))

json.each do |c|
  Customer.create!(c)
end
