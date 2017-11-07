require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "is a working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      # data can be xml or json so we want to ensure it is json
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies" do
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
  end
end
