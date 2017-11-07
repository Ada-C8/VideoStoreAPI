require "test_helper"

describe Movie do
  let(:movie_data) {
    {
    title: "This is a new movie",
    overview: "Not sure what kind of movie this is",
    release_date: 1960-06-16,
    inventory: 1,
    available_inventory: nil
    }
  }
  
  describe "validations" do
    it "allows a movie to be created with all required parameters" do
      before_count = Movie.all.count

      movie = Movie.new(movie_data)
      movie.save

      movie.must_be :valid?
      Movie.count.must_equal before_count + 1
    end

    it "will not be created without the required parameters" do
      before_count = Movie.all.count
      invalid_data = {
        title: "",
        overview: "",
        release_date: "",
        inventory: "",
        available_inventory: nil
      }
      movie = Movie.new(invalid_data)

      movie.wont_be :valid?
      Movie.count.must_equal before_count
    end

    it "sets the available_inventory to the current_invetory" do
      movie = Movie.new(movie_data)
      movie.save

      movie.available_inventory.must_equal 1
    end
  end
end
