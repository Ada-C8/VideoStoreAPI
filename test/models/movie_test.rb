require "test_helper"

describe Movie do
  let(:movie) { Movie.new(
    "title": "Psycho",
    "overview": "When larcenous real estate clerk Marion Crane goes on the lam with a wad of cash and hopes of starting a new life, she ends up at the notorious Bates Motel, where manager Norman Bates cares for his housebound mother. The place seems quirky, but fine… until Marion decides to take a shower.",
    "release_date": "1960-06-16",
    "inventory": 8)
  }

  describe 'validations' do
    it 'is valid with valid data' do
      movie.must_be :valid?
    end

    it 'validates presence of title' do
      movie.title = nil

      movie.wont_be :valid?
      movie.errors.must_include :title
    end

    it 'validates presence of inventory' do
      movie.inventory = nil

      movie.wont_be :valid?
      movie.errors.must_include :inventory
    end

    it 'validates numericality of inventory' do
      movie.inventory = "dog"

      movie.wont_be :valid?
      movie.errors.must_include :inventory
    end

    it 'can have overview' do
      movie.must_respond_to :overview
    end

    it 'can have release date' do
      movie.must_respond_to :release_date
    end

    it 'has available_inventory' do
      movie.must_respond_to :available_inventory
    end

    it 'defaults available_inventory to match inventory' do
      movie.available_inventory.must_equal movie.inventory
    end
  end
end
