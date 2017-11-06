require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
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
      keys = %w(inventory overview release_date title)
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
      must_respond_with :success
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

    it "Creates a new movie" do
      assert_difference "Movie.count", 1 do
        post movies_url, params: { movie: movie_data }
        assert_response :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      # Check that the ID matches
      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it "Returns an error for an invalid movie" do
      bad_data = movie_data.clone()
      bad_data.delete(:title)
      assert_no_difference "Movie.count" do
        post movies_url, params: { movie: bad_data }
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "title"
    end
  end
end
