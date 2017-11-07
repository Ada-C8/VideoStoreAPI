require "test_helper"

describe Movie do
  before do
    @movie1 = movies(:Jaws)
    @movie2 = movies(:Goonies)
    @movie3 = Movie.new(title: 'new movie',  overview: 'something@email.com', release_date: '01/01/1970', inventory: 99)
  end


  describe "relations" do
    it "a movie can have a many customers" do
      @movie1.must_respond_to :customers
    end

    it "a movie can have zero customers" do
      Rental.destroy_all
      @movie1.must_respond_to :customers
    end

    it "a movie can have many rentals" do
      @movie1.must_respond_to :rentals
    end

    it "a movie can have zero rentals" do
      Rental.destroy_all
      @movie1.must_respond_to :rentals
    end

  end

  describe 'validations' do
    it 'allows a new movie to be created' do
      @movie3.save
      @movie3.must_be :valid?
    end

    it 'must have a title' do
      @movie3.title = nil
      @movie3.wont_be :valid?
    end

    it 'must have a overview' do
      @movie3.overview = nil
      @movie3.wont_be :valid?
    end

    it 'must have a release_date' do
      @movie3.release_date = nil
      @movie3.wont_be :valid?
    end

    it 'must have a inventory' do
      @movie3.inventory = nil
      @movie3.wont_be :valid?
    end
  end

  describe "custom methods" do
    describe "set_available_inventory" do
      it "will available_inventory to the same value as inventory" do
        inventory = @movie3.inventory
        # show that inventory and available_inventory are not the same
        @movie3.available_inventory.wont_equal inventory
        # save
        @movie3.save
        # show that after save inventory equals available_inventory
        @movie3.available_inventory.must_equal inventory
      end
    end
  end
end
