require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path

      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array of hashes" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.each do |element|
        element.must_be_kind_of Hash
      end
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_path
      body = JSON.parse(response.body)
      body.must_equal []
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:magic).id)
      must_respond_with :success
    end
    it "returns an error for invalid id" do
      movies(:magic).destroy
      get movie_path(movies(:magic).id)
      must_respond_with :not_found
    end
    it "returns a movie with exactly the required fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(movies(:magic).id)

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end
  end

  describe "create" do
    it "can create a movie given the required params" do
      movie_data =  {title: "Space Jam", overview: "Great movie", release_date: "1994-01-01", inventory: 5}

      proc {
        post movies_path params: movie_data
        must_respond_with :success
      }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"
    end

    it "renders bad request given invalid data" do
      movie_data = {title: nil, overview: "Great movie", release_date: "1994-01-01", inventory: 5}

      proc {
        post movies_path params: movie_data
        must_respond_with :bad_request
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
    end
  end
end
