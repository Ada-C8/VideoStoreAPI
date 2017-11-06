require "test_helper"

describe Movie do
  let(:dune) { movies(:dune) }
  let(:gremlins) { movies(:gremlins) }
  describe "validations" do
    it "must have a title" do
      dune.title = nil
      dune.valid?.must_equal false
    end

    it "must have an inventory that is greater than 0" do
      gremlins.inventory = nil
      gremlins.valid?.must_equal false
      gremlins.inventory = 0
      gremlins.valid?.must_equal false
    end

    it "must have a release date" do
      dune.release_date = nil
      dune.valid?.must_equal false
    end
  end
end
