JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end


# require 'date'
# JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
#   this_customer = Customer.new
#   this_customer.name = customer["name"]
#   this_customer.registered_at = customer["registered_at"]
#   this_customer.address = customer["address"]
#   this_customer.city = customer["city"]
#   this_customer.state = customer["state"]
#   this_customer.postal_code = customer["postal_code"]
#   this_customer.phone = customer["phone"]
#   this_customer.save
# end
#
#
# JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
#   this_movie = Movie.new
#   this_movie.title = movie["title"]
#   this_movie.overview = movie["overview"]
#   this_movie.release_date = movie["release_date"]
#   this_movie.inventory = movie["inventory"]
#   this_movie.created_at = Date.today
#   this_movie.updated_at = Date.today
#   this_movie.save
# end
