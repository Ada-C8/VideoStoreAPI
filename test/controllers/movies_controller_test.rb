require "test_helper"

describe MoviesController do

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
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

    it "returns an empty array if there are no movie" do
      Movie.destroy_all
      get movies_path

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    let(:movie) { movies(:movie1) }

    it "can get a movie" do
      get movie_path(movie.id)
      must_respond_with :success
    end

    it "returns an error for an invalid id" do
      movie.destroy()
      get movie_path(movie.id)
      must_respond_with :not_found
    end

    it "returns a movie with exactly the required fields" do
      keys = %w(available_inventory inventory overview release_date title)

      get movie_path(movie.id)

      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys

    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Jack & the BeanStalk",
      }
    }

    let(:invalid_movie_data) {
      {
        title: nil
      }
    }

    it "Creates a new movie" do
      assert_difference "Movie.count", 1 do
        post movies_path, params: { movie: movie_data }
        assert_response :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "Returns an error for an invalid movie" do
      post movies_path, params: { movie: invalid_movie_data }
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end
end
