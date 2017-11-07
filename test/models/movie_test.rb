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

  describe "relationship between movie and rentals" do
    before do
      @movie = movies(:movie_one)
    end

    it "movie responds to rentals" do
      @movie.must_respond_to :rentals
    end

    it "lists rentals for a given movie"  do
      @movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "relationship between movies and customers" do
    before do
      @movie = movies(:movie_one)
    end

    it "movie responds to customers" do
      @movie.must_respond_to :customers
    end

    it "lists customers for a given movie"  do
      @movie.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end
  end

  describe "inventory" do
    it "returns false if a movie does not have any inventory" do
      movie_data =
        {
          title: "Jack",
          overview: "Blahblah",
          release_date: "1984",
          inventory: 0
        }


      movie = Movie.new(movie_data)

      movie.inventory?.must_equal false
    end

    it "returns true if a movie has at least one in inventory" do
      movie = movies(:movie_one)

      movie.inventory?.must_equal true
    end
  end

  describe "reduce inventory" do
    it "will reduce the inventory of a movie by one" do
      movie = movies(:movie_one)
      start_inventory = movie.inventory
      movie.reduce_inventory
      movie.inventory.must_equal start_inventory - 1
    end
  end

  describe "increase inventory" do
    it "will reduce the inventory of a movie by one" do
      movie = movies(:movie_one)
      start_inventory = movie.inventory
      movie.increase_inventory
      movie.inventory.must_equal start_inventory + 1
    end
  end
end
