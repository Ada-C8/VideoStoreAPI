require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all

      get movies_path
    end

    it "returns a json" do
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
      keys = %w(inventory overview release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "returns an error for an invalid id" do
      movies(:two).destroy
      get movie_path(movies(:two))
      must_respond_with :not_found
    end

    it "returns movies with exactly the required fields" do
      keys = %w(inventory overview release_date title)
      get movie_path(movies(:one))
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Jack and The Beanstalk",
        overview: "The giant falls from the beanstalk. I think he's alive?",
        release_date: "1000-01-01",
        inventory: 2
      }
    }

    it "can create a movie" do
      assert_difference "Movie.count", 1 do
        post movies_path, params:{ movie: movie_data }
      end
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end
  end
end
