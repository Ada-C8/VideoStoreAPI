require "test_helper"

describe Movie do
  before do
    @invalid_movie_data = {}
  end
  describe "validations" do
    it "can be created with all fields" do
      valid = movies(:movie_one).valid?
      valid.must_equal true
    end

    it "requires a title" do
      invalid_movie = Movie.new(@invalid_movie_data)
      valid = invalid_movie.valid?
      valid.must_equal false
      invalid_movie.errors.messages.must_include :title
    end

    it "requires an overview" do
      invalid_movie = Movie.new(@invalid_movie_data)
      valid = invalid_movie.valid?
      valid.must_equal false
      invalid_movie.errors.messages.must_include :overview
    end

    it "requires a release date" do
      invalid_movie = Movie.new(@invalid_movie_data)
      valid = invalid_movie.valid?
      valid.must_equal false
      invalid_movie.errors.messages.must_include :release_date
    end

    it "requires inventory to be specified" do
      invalid_movie = Movie.new(@invalid_movie_data)
      valid = invalid_movie.valid?
      valid.must_equal false
      invalid_movie.errors.messages.must_include :inventory
    end
  end
end
