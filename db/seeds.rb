JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

#TODO - come back to this
# JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
#   Movie.create!(movie)
# end
