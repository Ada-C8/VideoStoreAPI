require "test_helper"

describe Movie do
  let(:movie) { Movie.new( title: 'Cool Movie',
    inventory: "10")
    }

  describe 'validations' do
    it 'can be created with valid data' do
      movie.must_be :valid?
    end

    describe 'title' do
      it 'requires title' do
        movie.title = nil
        movie.inventory = '10'
        movie.save
        movie.errors.messages.must_include :title
        movie.wont_be :valid?
      end
    end

    describe "tests for presence of inventory" do
      it "will reject missing inventory" do
        movie.inventory = nil
        movie.wont_be :valid?
        movie.errors.messages.must_include :inventory
      end

      it "should work if inventory is 0" do
        movie.inventory = 0
        movie.must_be :valid?
      end
    end
  end

  describe 'relationships' do
    it "has a list of rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "available_inventory" do
    it "should return available_inventory" do
      movie = Movie.first
      available = movie.inventory
      movie.available_inventory.must_equal available
    end

    # write addidtional test for available_inventory
  end

end
