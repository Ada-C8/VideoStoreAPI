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

  describe "create" do

    let(:movie_data) {
      {
        title: "Jack",
        overview: "Blahblah",
        release_date: "1984",
        inventory: 5
      }
    }

    it "Create a Movie" do
      proc {
        post movies_path, params: {movie: movie_data}
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end

    it "Won't change the database if data is missing" do
      invalid_movie_data = {
        overview: "Nada",
        release_date: "1984",
        inventory: 5
      }

      proc {
        post movies_path, params: { movie: invalid_movie_data}
        }.wont_change 'Movie.count'

      body = JSON.parse(response.body)
      body.must_equal "errors"=>{"title"=>["can't be blank"]}
    end

  end
end
