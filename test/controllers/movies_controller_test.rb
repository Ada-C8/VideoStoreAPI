require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "it is a working route" do
      get movies_path
      must_respond_with :success
    end
    it "it returns a json" do
      get movies_path
      response.header['Content-type'].must_include 'json'
    end
    it "it returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it "it returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end
    it "it returns movies with the exact required fields" do
      keys = %w(id name registered_at address city state postal_code phone account_credit).sort
      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
    it "it returns an empty array if no movies with status 200" do
      Movie.destroy_all

      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array

      body.must_be :empty?
    end
  end
end
