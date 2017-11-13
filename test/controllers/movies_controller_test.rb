require "test_helper"

describe MoviesController do
  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)
      get movies_url
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
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "responds correctly when movie not found" do
      invalid_movie_id = Movie.all.last.id + 1
      get movie_path(invalid_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => "true"
    end

  end

  describe "create" do
    let(:movie_data) {
      {
        title: "Kazaam",
        overview: "it existed",
        inventory: 10,
        release_date: "9 Aug 1994"
      }
    }
    it "creates a movie" do
      proc{
        post movies_path, params: {movie: movie_data}
      }.must_change 'Movie.count', 1

      must_respond_with :success
    end
    #
    # it "won't change the db if data is missing" do
    #   invalid_movie_data = {
    #     title: "Shazaam",
    #     overview: "it existed",
    #     release_date: "9 Aug 1994"
    #   }
    #   proc{
    #     post movies_path, params: { movie: invalid_movie_data}
    #   }.wont_change "Movie.count"
    #   must_respond_with :bad_request
    #   body = JSON.parse(response.body)
    #   body.must_equal "errors" => {"name" => ["can't be blank"]}
    # end

  end
end
