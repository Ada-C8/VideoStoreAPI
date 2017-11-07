require 'test_helper'

describe MoviesController do
  let(:valid_id) { Movie.first.id }
  let(:invalid_id) { Movie.last.id + 1 }

  describe 'index' do
    it 'it is a working route' do
      get movies_path
      must_respond_with :success
    end
    it 'it returns a json' do
      get movies_path
      response.header['Content-type'].must_include 'json'
    end
    it 'it returns an array' do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end
    it 'it returns all of the movies' do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end
    it 'it returns movies with the exact required fields' do
      keys = %w(id title overview release_date inventory available_inventory).sort
      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
    it 'it returns an empty array if no movies with status 200' do
      Movie.destroy_all

      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array

      body.must_be :empty?
    end
  end

  describe 'show' do
    it 'is a working route' do
      get movie_path(valid_id)

      must_respond_with :success
    end

    it 'returns json' do
      get movie_path(valid_id)

      response.header['Content-type'].must_include 'json'
    end

    it 'returns a hash' do
      get movie_path(valid_id)
      body = JSON.parse(response.body)

      body.must_be_kind_of Hash
    end

    it 'returns movies with the exact required fields' do
      keys = %w(id title overview release_date inventory available_inventory).sort
      get movie_path(valid_id)
      body = JSON.parse(response.body)

      body.keys.sort.must_equal keys
    end

    it 'returns an empty hash with a 404 status if no movie is found' do
      get movie_path(invalid_id)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.keys.must_include "nothing"
    end
  end

  describe 'create' do
    let(:movie_data ) {
      {
      "title": "The Exorcist",
      "overview": "12-year-old Regan MacNeil begins to adapt an explicit new personality as strange events befall the local area of Georgetown. Her mother becomes torn between science and superstition in a desperate bid to save her daughter, and ultimately turns to her last hope: Father Damien Karras, a troubled priest who is struggling with his own faith.",
      "release_date": "1973-12-26",
      "inventory": 7
      }
  }
    it "creates a movie" do
      proc {
        post movies_path, params: movie_data
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end
    it "won't save a movie in database with invalid data" do
      invalid_movie_data = {
      "overview": "12-year-old Regan MacNeil begins to adapt an explicit new personality as strange events befall the local area of Georgetown. Her mother becomes torn between science and superstition in a desperate bid to save her daughter, and ultimately turns to her last hope: Father Damien Karras, a troubled priest who is struggling with his own faith.",
      "release_date": "1973-12-26",
      "inventory": 7
      }

      proc {
        post movies_path, params: invalid_movie_data
      }.wont_change 'Movie.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body["errors"].must_include "title" 
    end

  end
end
