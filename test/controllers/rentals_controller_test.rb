require "test_helper"
describe RentalsController do
  describe "check_out" do
    it "succeeds" do
      post checkout_path
      must_respond_with :success
    end

    it "decrements number of movies available in inventory" do

    end

    it "increments number of movies customer has rented" do

    end

    it "doesn't succeed for customer that doesn't exit " do

    end

    it "doesn't succeed for movie that doesn't exit " do

    end

    it "doesn't succeed if zero inventory " do

    end

    it "succeeds if sufficient inventory " do

    end

  end

  describe "check_in" do
    it "succeeds" do
      post checkin_path
      must_respond_with :success
    end

    it "increments number of movies available in inventory" do

    end

    it "decrements number of movies customer has rented" do

    end

    it "doesn't succeed for customer that doesn't exit " do

    end

    it "doesn't succeed for movie that doesn't exit " do

    end

  end

  describe "overdue" do
    it "succeeds" do
      get overdue_path
      must_respond_with :success
    end

    it "returns list  of all customers with overdue movies" do

    end

    it "returns empty array if no customers with overdue movies" do

    end

    it "succeeds wether there are any overdue customers" do

    end
  end

end
