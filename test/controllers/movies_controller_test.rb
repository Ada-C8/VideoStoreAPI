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

    it "must return an empty array if no movies exist" do
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

  describe '#show' do
    before do
      valid_movie = movies(:one)
      @valid_id = Movie.find_by(title: valid_movie.title).id
    end

    it "returns json" do
      get movie_path(@valid_id)
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(@valid_id)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "finds a movie with a valid id" do
      get movie_path(@valid_id)
      must_respond_with :success
      body = JSON.parse(response.body)
      body["title"].must_equal Movie.find_by(id: @valid_id).title
    end

    it "returns status not_found with an invalid id" do
      invalid_id = -1
      get movie_path(invalid_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].keys.must_include "id"
      body["errors"]["id"].must_include "Could not find movie with id: #{invalid_id}"
    end
  end

  describe "create" do
    it "must respond with JSON" do
      post create_movie_path, params: {title: "Raiders of the Lost Ark"}
      response.header['Content-Type'].must_include 'json'
    end

    it "returns only the required fields" do
      key = ['id']
      post create_movie_path, params: {title: "Raiders of the Lost Ark"}
      body = JSON.parse(response.body)
      body.keys.sort.must_equal key
    end

    it "can create a new movie" do
      proc {post create_movie_path, params: {title: "Raiders of the Lost Ark"}}.must_change "Movie.count", 1
      must_respond_with :ok
      body = JSON.parse(response.body)
      body["id"].must_be_instance_of Integer
    end

    it "cannot save a duplicate movie (same title)" do
      proc {post create_movie_path, params: {title: "Raiders of the Lost Ark"}}.must_change "Movie.count", 1
      proc {post create_movie_path, params: {title: "Raiders of the Lost Ark"}}.must_change "Movie.count", 0
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body["ok"].must_equal false
      body["errors"].keys.must_include "title"
      body["errors"]["title"].must_include "Movie title must be unique."
    end
  end

end
