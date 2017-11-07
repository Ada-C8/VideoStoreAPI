require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:movie2) {Movie.new(title: "The II", release_date: "Mon, 06 Nov 2017 14:32:26 -0800")}

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
    let(:psycho) {movies(:psycho)}
    it "has many rentals" do
      psycho.rentals.count.must_equal 2
      psycho.rentals.each do |r|
        r.must_be_instance_of Rental
      end
    end



  end #relationships
end
