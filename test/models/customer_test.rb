require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  describe "relationships" do
    it "has a collection of rentals" do
      c = Customer.new(name: "Mira")
      c. save
      m_id = Movie.first.id
      c_id = c.id

      c.must_respond_to :rentals
      c.rentals.must_be :empty?

      r = Rental.new(customer_id: "c_id", movie_id: "m_id", due_date: Date.new(2017, 12, 1))

      c.rentals << r
      c.rentals.must_include r
    end # collection of rentals
  end # relationships

  describe "validations" do
    it "can be created if all fields are provided" do
      start_count = Customer.count
      c = Customer.new(name: "Tamira", registered_at: "Date registered", address: "An address", city: "Seattle", state: "WA", postal_code: "zip", phone: "111111111", account_credit: 15.50)

      c.must_be :valid?

      c.save
      Customer.count.must_equal start_count + 1
    end # can be created

    it "can't be created without a title" do
      start_count = Customer.count
      c = Customer.new(registered_at: "Date registered", address: "An address", city: "Seattle", state: "WA", postal_code: "zip", phone: "111111111", account_credit: 15.50)

      c.wont_be :valid?
      c.errors.messages.must_include :name

      # can't be saved because it isn't valid
      c.save
      Customer.count.must_equal start_count

    end
  end # validations

  describe "movies_checked_out_count" do
    it "will return the number of checked out movies for that customer" do
      customer = Customer.first
      customer.movies_checked_out_count.must_equal 0
      # TO DO add test after implementing check out method

    end
  end
end
