require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:movie2) {Movie.new(title: "The II", release_date: "Mon, 06 Nov 2017 14:32:26 -0800")}
  let(:psycho) {movies(:psycho)}

  describe "VALIDATIONS" do
    it "Can be created" do
      movie.title = "I'll be stronger tomorrow"
      movie.release_date= "Mon, 06 Nov 2017 14:32:26 -0800"
      movie.valid?.must_equal true
      proc {movie.save}.must_change("Movie.count", 1)
    end

    it "cannot be created without title, release_date" do
      movie.valid?.must_equal false
      movie.errors.must_include :title
      movie.errors.must_include :release_date
    end

    it "has an id" do
      movie2.save
      id = Movie.find_by(title: "The II").id

      movie2.id.must_equal id
    end

  end #VALIDATIONS
  describe "relationships" do
    it "has many rentals" do
      psycho.rentals.count.must_equal 2
      psycho.rentals.each do |r|
        r.must_be_instance_of Rental
      end
    end

    it "rental exists if the movie is deleted" do
      proc {psycho.destroy}.must_change('Movie.count', -1)

      rentals(:rental1).must_be_instance_of Rental
      rentals(:rental2).must_be_instance_of Rental
    end
  end #relationships

  describe "available_inventory" do
    it "returns the number available to rent" do
      psycho.out = psycho.inventory - 1

      psycho.available_inventory.must_equal 1
    end

    it "returns inventory if out is nil" do
      psycho.out = nil

      psycho.available_inventory.must_equal psycho.inventory
    end
  end #available_inventory

  describe "rent" do
    it "increases movies out if available" do
      proc {
        psycho.rent
      }.must_change('psycho.out', +1)
    end

    it "returns false if movie is unavailable" do
      psycho.inventory = 0
      psycho.rent.must_equal false
    end
  end # rent

  describe "return" do
    it "decreases movies out if inventory isn't surpassed" do
      psycho.rent
      proc {
        psycho.return
      }.must_change('psycho.out', -1)
    end

    it "returns false if inventory is full" do
      psycho.return.must_equal false
    end
  end # return
end
