require "test_helper"

describe MoviesController do
  it "can get the zomg path" do
    get zomg_path
    must_respond_with :success
    body = JSON.parse(response.body)
    body["message"].must_equal "it works!"
  end
  it "returns json" do
    get zomg_path
    response.header['Content-Type'].must_include 'json'
  end
end
