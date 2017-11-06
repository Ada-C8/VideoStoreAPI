require "test_helper"

describe MoviesController do
  describe "INDEX" do
    it "successfully returns json as an Array" do
      get movies_path
      must_respond_with :success

      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_instance_of Array
    end
  end

end
