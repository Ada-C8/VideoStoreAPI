class CustomersController < ApplicationController
  def test
      render(
        json: { test: "it works!!" }
      )
  end
end
