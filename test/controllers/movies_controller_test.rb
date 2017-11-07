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

    it "returns an array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
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

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "is a working route" do
      first_id = Movie.first.id
      get movie_path(first_id)
      must_respond_with :success
    end

    it "responds as expected when movie not found" do
      first_id = Movie.first.id + 1
      get movie_path(first_id)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "id" => "Invalid Movie ID"
    end
  end
end
