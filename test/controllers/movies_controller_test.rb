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
     keys = %w(available_inventory created_at id inventory overview release_date title updated_at)
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
   let(:movie_data) {
      {
        release_date: "Nov",
        title: "10 Things I hate about you"
      }
    }
   it "creates a new movie" do
     assert_difference "Movie.count", 1 do
        post movies_path, params: { movie: movie_data }
        assert_response :success
      end
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"


      Movie.find(body["id"]).title.must_equal movie_data[:title]
   end

   it "Returns an error for an invalid movie" do
      bad_data = movie_data.clone()
      bad_data.delete(:title)
      assert_no_difference "Movie.count" do
        post movies_path, params: { movie: bad_data }
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end


 end

end
