require "test_helper"

describe MoviesController do
  describe 'index' do
    it 'is a working route' do
      get movies_url
      must_respond_with :success
    end

    it 'returns json' do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it 'returns an array even if no data' do
      Movie.destroy_all

      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.count.must_equal 0
      body.must_equal []

    end

    it "returns movies with exactly the required fields" do
      keys = %w(title overview release_date inventory)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end

  end

  describe 'show' do
    it 'can get a movie' do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it 'returns error for invalid movie' do
      movies(:two).destroy
      get movie_path(movies(:two).id)
      must_respond_with :not_found
    end
  end
end
