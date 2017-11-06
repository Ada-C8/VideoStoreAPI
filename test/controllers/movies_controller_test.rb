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
      keys = %w(inventory overview release_date title)
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

end
