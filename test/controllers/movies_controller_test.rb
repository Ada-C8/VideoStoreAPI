require "test_helper"

describe MoviesController do
  let(:movie) { movies(:psycho) }

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get movies_path
      # This returns the body of all pets!
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns all movies with the requred fields" do
      keys = ["inventory", "overview", "release_date", "title"]

      get movies_path

      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an array if there are no movies" do
      Movie.destroy_all

      get movies_path

      body = JSON.parse(response.body)
      body.must_be :empty?
    end
  end

  describe "show" do
    it "returns success if a movie is found" do
      get movie_path(movie)

      must_respond_with :success
    end

    it "returns not found if a movie is not found" do
      get movie_path(Movie.last.id + 1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Harry Potter",
        overview: "A boy who lived with the scar",
        release_date: 2001-11-16,
        inventory: 3
      }
    }

    it "returns success if a movie is created" do
      proc {
        post movies_path, params: { movie: movie_data }
        }.must_change 'Movie.count', 1

      must_respond_with :success
    end
  end

  describe "update" do
    it "returns sucess if the movie is updated" do
    end
  end
end
