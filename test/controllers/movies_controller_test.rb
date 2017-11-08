require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route - must return success" do
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

    it "returns all the movies" do
      get movies_path
      body = JSON.parse(response.body)

      body.length.must_equal Movie.count
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_path

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_instance_of Array
      body.must_be :empty?
    end

    it "returns movies with the required fields" do
      keys = %w(id inventory overview release_date title)

      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    let(:dune) { movies(:dune) }

    it "can get a movie" do
      get movie_path(dune.id)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal dune.title
    end

    it "returns not found if movie id is invalid" do
      dune.destroy
      get movie_path(dune.id)
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      { title: "Nightmare before Xmas",
        overview: "Xmas movie",
        release_date: Date.new(1997-12-25),
        inventory: 12
      }
    }

    it "creates a new movie" do
      proc { post movies_path, params: movie_data }.must_change 'Movie.count', 1

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "returns bad request for an invalid movie" do
      bad_data = movie_data.clone()
      bad_data.delete(:title)

      proc { post movies_path, params: { movie: bad_data } }.wont_change 'Movie.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end

end
