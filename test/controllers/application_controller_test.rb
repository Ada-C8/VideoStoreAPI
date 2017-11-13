require 'test_helper'

describe ApplicationController do
  describe "routes" do
    it "returns json at zomg" do
      get zomg_path
      response.header['Content-Type'].must_include 'json'
    end
  end
end
