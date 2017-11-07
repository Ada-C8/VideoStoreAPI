require "test_helper"

describe RentalsController do
  it "should get checkout" do
    get rentals_checkout_url
    value(response).must_be :success?
  end

  it "should get checkin" do
    get rentals_checkin_url
    value(response).must_be :success?
  end

  it "should get overdue" do
    get rentals_overdue_url
    value(response).must_be :success?
  end

end
