require "test_helper"


describe MoviesController do

  describe "index" do

   it "is a working route" do
     get movies_path
     must_respond_with :success
   end
   it "returns json" do
     get movies_path
     response.header['Content-Type'].must_include 'json'
   end

   it "returns and array" do
     get movies_path
     body = JSON.parse(response.body)
     body.must_be_kind_of Array
   end

   it "returns all movies" do
     get movies_path

     body = JSON.parse(response.body)
     body.length.must_equal Movie.count
   end

   it "returns movies with the required keys" do
     keys = %w(id release_date title)
     get movies_path
     body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
   end
 end

 describe "show" do

   it "can find a movie by ID" do
     get movie_path(movies(:movie_two).id)
     must_respond_with :success
   end

   it "responds with not_found if movie id doesn't exist" do
     get movie_path(id: -1)
     must_respond_with :not_found
   end
 end

 describe "create" do
   it "creates a new movie" do
     
   end
 end

end
