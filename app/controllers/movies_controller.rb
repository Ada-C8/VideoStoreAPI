class MoviesController < ApplicationController

  def zomg
    render json: {
      status: 200,
      message: "IT WORKS!"
    }.to_json
  end
  
end
