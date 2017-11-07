require "test_helper"
describe RentalsController do
  describe "check_out" do
    it "succeeds" do
      post checkout_path
      must_respond_with :success
    end
  end

  describe "check_in" do
    it "succeeds" do
      post checkin_path
      must_respond_with :success
    end
  end

  describe "overdue" do
    it "succeeds" do
      get overdue_path
      must_respond_with :success
    end
  end

end
