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
      keys = %w(id title overview release_date inventory available_inventory)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end

  end

  describe 'show' do
    it 'can get a movie' do
      get movie_path(movies(:two).title)
      must_respond_with :success
    end

    it 'returns error for invalid movie' do
      movies(:two).destroy
      get movie_path(movies(:two).id)
      must_respond_with :not_found
    end
  end

  describe 'create' do
    let(:movie_data) {
      {
        title: "Pretty Woman",
        overview: "Julia Roberts is there.",
        release_date: "11/06/1999",
        inventory: 5
      }
    }
    it "creates a new movie" do
      assert_difference 'Movie.count', 1 do
        post movies_url, params: {movie: movie_data}
        assert_response :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find_by_id(body["id"]).title.must_equal movie_data[:title]
    end

    it "returns bad request for an invalid movie" do
      bad_data = movie_data.dup()
      bad_data.delete(:title)
      assert_no_difference 'Movie.count' do
        post movies_url, params: {movie: bad_data}
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_include "title"
    end

  end

end
