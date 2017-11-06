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
  end

  # it "should get show" do
  #
  # end
  #
  # it "should get create" do
  #
  # end

end
