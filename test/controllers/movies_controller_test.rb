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

    it "returns an empty array if there are no movies" do
      Movie.destroy_all

      get movies_path

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end #end index

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "responds correctly when a movie is not found" do
      invalid_movie_id = Movie.all.last.id + 1

      get movie_path(invalid_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end #end show

  describe "create" do
    let(:movie_data) {
      {
        title: "The movie",
        release_date: "2012-12-21"
      }
    }
    it "create a movie" do
      proc {
        post movies_path, params: { movie: movie_data}
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end

    it "won't add record to database if some data is missing" do
      invalid_movie_data = {
        release_date: "2012-12-21"
      }

      proc {
        post movies_path, params: { movie: invalid_movie_data }
      }.wont_change 'Movie.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => { "title" => ["Movie must have a title"]}
    end
  end
end
