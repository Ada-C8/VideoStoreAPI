require "test_helper"

describe MoviesController do
  describe "index" do
    # Positive test
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end
    #

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns all movies with exactly the required fields" do
      keys = %w(id title release_date)

      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.must_equal keys
      end
    end

    # This test passes when yml fixture data is commented out; cannot run test with other tests.
    # it "returns a message when list of movies is empty" do
    #   get movies_path
    #   must_respond_with :success
    #
    #   body = JSON.parse(response.body)
    #   body.must_equal "nothing" => true
    # end
  end #index tests

  describe "show" do
    # This bit is up to you!
    it "can get a movie by id" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "responds correctly when a movie is not found" do
      invalid_movie_id = Movie.last.id + 1
      get movie_path(invalid_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end #show tests

  describe "create movie" do
    let(:movie_data) {
      {
        title: "Fake Movie",
        overview: "A stirring adventure",
        release_date: "1972-06-06",
        inventory: 10
      }
    }

    it "Creates a new movie" do
      proc {
        post movies_path, params: {movie: movie_data}
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end #creates movie

    it "Won't change the database if data is missing" do
      invalid_movie_data = {
        overview: "A stirring adventure",
        release_date: "1972-06-06",
        inventory: 10
      }

      proc {
        post movies_path, params: {movie: invalid_movie_data}
      }.wont_change 'Movie.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"title" => ["can't be blank"]}

    end #missing data
  end# create tests
end
