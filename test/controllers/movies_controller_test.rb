require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all

      get movies_path
    end

    it "returns a json" do
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
      keys = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:one).id)
      must_respond_with :success
    end

    it "returns an error for an invalid id" do
      movies(:two).destroy
      get movie_path(movies(:two))
      must_respond_with :not_found
    end

    it "returns movies with exactly the required fields" do
      keys = %w(available_inventory inventory overview release_date title)
      get movie_path(movies(:one))
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end
  end

  describe "create" do
    movie_data = {
      movie: {
        title: "Jack and The Beanstalk",
        overview: "The giant falls from the beanstalk. I think he's alive?",
        release_date: "1000-01-01",
        inventory: 2
      }
    }

    it "creates a movie" do
      start_count = Movie.count

      post movies_path, params: movie_data
      Movie.count.must_equal start_count + 1

      body = JSON.parse(response.body)
      puts "Print Body: #{body}"
      body.must_be_kind_of Hash
      body.must_include "id"

      Movie.find(body["id"]).title.must_equal movie_data[:movie][:title]
    end

    # it "returns an error for an invalid movie" do
    #   bad_movie = movie_data.clone()
    #   bad_movie.delete(:title)
    #   assert_no_difference "Movie.count" do
    #     post movies_path, params: { movie: bad_movie }
    #     assert_response :bad_request
    #   end
    # end
  end
end
