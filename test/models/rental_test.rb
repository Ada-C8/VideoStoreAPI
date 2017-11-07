require "test_helper"

describe Rental do

  #rentals YAML
  let(:rental_one) { rentals :rental_one }
  let(:rental_two) { rentals :rental_two }

  #


  it "must be valid" do
    value(rental).must_be :valid?
  end
end
