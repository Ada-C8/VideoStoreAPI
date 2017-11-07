JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end

i = 0
JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  customer_id = Customer.find_by(name: customer["name"]).id
  movie = JSON.parse(File.read('db/seeds/movies.json'))[i]
  movie_id = Movie.find_by(title: movie["title"]).id
  rental = Rental.new(
    customer_id: customer_id,
    movie_id: movie_id,
    checkout_date: Date.today,
    due_date: (Date.today + 5)
  )
  if rental.save
    puts "Created rental with customer_id: #{customer_id} and movie_id: #{movie_id}"
  else
    puts "Error could not create rental!!!!!!!!!!!!!!!!!!!!!!"
  end
  i += 1
  break if i == 100
end
