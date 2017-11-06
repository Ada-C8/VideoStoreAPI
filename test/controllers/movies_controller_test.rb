require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "it is a working route" do
      get movies_url
      must_respond_with :success
    end
    it "it returns a json" do
      get movies_url
      response.header['Content-type'].must_include 'json'
    end
    it "it returns an array" do

    end
    it "it returns all if the movies" do

    end
    it "it returns movies with the exact required field" do

    end
    it "it returns an empty array if no movies with status 200" do

    end
  end
end
