require "test_helper"

describe MoviesController do
  describe "INDEX" do
    it "successfully returns json as an Array" do
      get movies_path
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_instance_of Array
    end

    it 'returns ALL of the movies' do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns customers with exactly the fields required" do
      keys = %w(id title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end
  end

end
