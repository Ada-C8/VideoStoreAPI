require "test_helper"

describe MoviesController do

  describe "test-test" do
    it "can get the zomg path" do
      get zomg_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body["message"].must_equal "it works!"
    end
    it "returns json" do
      get zomg_path
      response.header['Content-Type'].must_include 'json'
    end
  end

  describe "#index" do
    before do
      get movies_path
    end

    it "is a real route" do
      must_respond_with :success
    end

    it "returns an array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it "returns all the movies" do
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end
    it "returns movies with exactly the required fields" do
      keys = %w(available_inventory inventory overview release_date title)
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
    it "returns an empty array is there are no movies" do
      Movie.destroy_all
      get movies_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "#show" do
    let(:movie) {movies(:harry_sally)}

    it "shows an existing movie" do
      get movie_path(movie.id)
      must_respond_with :success

      body= JSON.parse(response.body)

      body.must_be_kind_of Hash
      status.must_equal 200
    end

    it "returns a movie with all of the required fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "returns an error message if no movie is found" do
      get movie_path((Movie.last.id) +  1)
      body = JSON.parse(response.body)
      body["errors"].must_include "id"
      body["errors"]["id"].must_equal ["No Movie with ID #{(Movie.last.id) +  1} Found"]

      status.must_equal 404
    end

  end

  describe "#create" do
    let(:new_movie_data) {
      {title: "Super Movie",
      overview: "The Greatest movie of all time",
      inventory: 12,
      release_date: "2017-11-06"
      }
    }

    it "creates a movie given valid data" do
      count = Movie.count
      # proc {
      #   post movies_path, params: new_movie_data
      # }.must_change "Movie.count", 1

      post movies_path, params: new_movie_data

      Movie.count.must_equal count+1

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      status.must_equal 201

    end

    it "returns an error for an invalid movie" do
      bad_data = new_movie_data.clone()
      bad_data.delete(:title)

      assert_no_difference "Movie.count" do
        post movies_url, params: {movie: bad_data}
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

  end

end
