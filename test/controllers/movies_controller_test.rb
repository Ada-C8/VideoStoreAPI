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

end
