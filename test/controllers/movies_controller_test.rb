require "test_helper"

describe MoviesController do
  describe "#index" do
    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "must return an empty arry if no movies exist" do
      Movie.destroy_all
      get movies_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_equal []
    end

    it "will return an array of all movies if they exist" do
      get movies_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_instance_of Array
      body.length.must_equal Movie.count
    end
  end

end
