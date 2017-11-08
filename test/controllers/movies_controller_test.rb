require "test_helper"


describe MoviesController do

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = ["id", "inventory", "overview", "release_date", "title" ]
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      # Arrange
      Movie.destroy_all

      # Act
      get movies_path

      # Assert
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "responds correctly when movie is not found" do
      invalid_movie_id = Movie.all.last.id + 1
      get movie_path(invalid_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

    #TO DO
    ### Test available inventory

  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Cool movie",
        inventory: 7,
        release_date: "feb",
        overview: "Something"
      }
    }


    it "Create a Movie" do
      proc {
        post movies_path, params: {movie: movie_data}
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end

    it "won't change the db if given invalid data" do
      invalid_movie_data =
        {
          title: nil,
          inventory: 7,
          release_date: "feb",
          overview: "Something"
        }
      proc {
        post movies_path, params: {movie: invalid_movie_data}
      }.wont_change 'Movie.count'

      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"title" => ["can't be blank"]}
    end
  end
end
