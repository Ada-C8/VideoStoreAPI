require "test_helper"

describe MoviesController do
  describe "index" do
    it "is working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json for a request" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_url
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      response.header['Content-Type'].must_include 'json'
      must_respond_with :success
    end

    it "returns individual movies with exactly the required fields" do
      keys = %w(available_inventory id inventory overview release_date title)
      get movie_path(movies(:two).id)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "gives 404 if movie does not exist" do
      get movie_path(99999999999999)
      response.header['Content-Type'].must_include 'json'
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Jaws 2",
        overview: "An insatiable great white shark terrorizes the townspeople of Amity Island AGAIN, The police chief, an oceanographer and a grizzled shark hunter seek to destroy the bloodthirsty beast.",
        release_date: "1981-06-19",
        inventory: 4
      }
    }

    it "creates a new movie" do
      assert_difference "Movie.count", 1 do
        post movies_url, params:  movie_data
        must_respond_with :ok
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "returns a Json error for an invalid movie" do
      bad_data = movie_data.delete(:title)
      proc{post movies_url, params:  bad_data}.must_change 'Movie.count', 0

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end

    it "doesn't create a movie if no title is given" do
      proc{post movies_url, params:  movie_data}.must_change 'Movie.count', 1
      bad_data = movie_data.delete(:title)
      proc{post movies_url, params:  bad_data}.must_change 'Movie.count', 0
      must_respond_with :bad_request
    end
  end
end
