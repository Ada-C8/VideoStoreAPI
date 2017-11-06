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
    end

    it 'validates presence of inventory' do
      movie.title = nil

      movie.wont_be :valid?
    end

    it 'validates numericality of inventory' do
      movie.title = "dog"

      movie.wont_be :valid?
    end
  end
end
