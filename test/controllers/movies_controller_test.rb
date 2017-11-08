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
  end

  describe "show" do
    it "can show a movie" do
      get movie_path(movies(:Jaws).id)
      must_respond_with :success
    end

    it "responses correctly when movie is not found" do
      invalid_movie_id = Movie.all.last.id + 1
      get movie_path(invalid_movie_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "errors" =>{"id"=>"Movie ID: #{invalid_movie_id} not found"}
    end
  end

  describe "create" do
    it "creates a movie with valid params" do
      params = {
        title: "awesome movie 1",
        overview: "awesome movie about awesome people",
        release_date: "2018-10-10",
        inventory: "5"
      }
      count = Movie.count
      post movies_path, params: params
      must_respond_with :ok
      Movie.count.must_equal count+1
    end

    it "does not create movie with missing information" do
      params = {
        overview: "awesome movie about awesome people",
        release_date: "2018-10-10",
        inventory: "5"
      }
      count = Movie.count

      post movies_path, params: params
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => {"title" => ["can't be blank"]}

      Movie.count.must_equal count
    end

    # # These tests are repititive and unneccessary. They all test that if a movie is missing information that it doesn't create a new one. We only need one test to cover that in the controller. Testing at an attribute level like the ones you have written below is done in the movie model tests for our validations and we don't need to duplicate this work in the controller. - SRB 11/7/16 2:26pm

    # it "does not create movie with no overview" do
    #   params = {
    #     title: "awesome movie 1",
    #     release_date: "2018-10-10",
    #     inventory: "5"
    #   }
    #   count = Movie.count
    #
    #   post movies_path, params: params
    #   must_respond_with :bad_request
    #
    #   body = JSON.parse(response.body)
    #   body.must_equal "errors" => {"overview" => ["can't be blank"]}
    #
    #   Movie.count.must_equal count
    # end

    # it "does not create movie with no release_date" do
    #   params = {
    #     title: "awesome movie 1",
    #     overview: "awesome movie about awesome people",
    #     inventory: "5"
    #   }
    #   count = Movie.count
    #
    #   post movies_path, params: params
    #   must_respond_with :bad_request
    #
    #   body = JSON.parse(response.body)
    #   body.must_equal "errors" => {"release_date" => ["can't be blank"]}
    #
    #   Movie.count.must_equal count
    # end

    # it "does not create movie with no inventory" do
    #   params = {
    #     title: "awesome movie 1",
    #     overview: "awesome movie about awesome people",
    #     release_date: "2018-10-10"
    #   }
    #
    #   count = Movie.count
    #   post movies_path, params: params
    #   must_respond_with :bad_request
    #
    #   body = JSON.parse(response.body)
    #   body.must_equal "errors" => {"inventory" => ["can't be blank"]}
    #
    #   Movie.count.must_equal count
    # end
  end
end
