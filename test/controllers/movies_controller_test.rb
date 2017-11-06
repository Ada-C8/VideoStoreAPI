require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe 'index' do
    it 'is a real working route' do
      get movies_path
      must_respond_with :success
    end

    it 'returns JSON' do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get movies_path
      body = JSON.parse(response.body)

      body.must_be_kind_of Array
    end

    it 'returns all movies' do
      get movies_path
      body = JSON.parse(response.body)

      body.length.must_equal Movie.count
    end

    it 'returns movies with exactly the required fields' do
      keys = %w(id title overview release_date inventory available_inventory)
      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.must_equal keys
      end
    end

    it 'returns an empty array if there are no movies' do
      Movie.destroy_all
      get movies_path
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "returns a hash with all of the fields about a particular movie" do
      get movie_path(movies(:one).id)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body["title"].must_equal movies("one").title
    end

    it "returns not found when movie does not exist" do
      invalid_movie_id = Movie.all.last.id + 1
      get movie_path(invalid_movie_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end

  describe 'create' do
    let (:movie_data) {
      {
        id: 3,
        title: "Scream",
        overview: "fun party",
        release_date: "yesterday",
        inventory: 10,
        available_inventory: 9
      }
    }

    it 'creates a new movie' do
      proc { post movies_path, params: {movie: movie_data}}.must_change 'Movie.count', 1

      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:title]
    end

    it 'returns an error for invalid movie' do
      invalid_movie_data = {
        title: "Dan"
      }

      proc {
        post movies_path, params: {
          movie: invalid_movie_data
        }
      }.wont_change 'Movie.count'

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash

      body.must_equal "errors" => {"inventory" => ["can't be blank"]}
    end
  end
end
