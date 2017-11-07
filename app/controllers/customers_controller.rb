class CustomersController < ApplicationController
  def index
  end

  def test
      render(
        json: { test: "it works!!" },
        status: :ok
      )
  end
end
