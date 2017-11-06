class MoviesController < ApplicationController

  def zomg
    render json: {
      status: 200,
      message: "IT WORKS!"
    }.to_json
  end

  def index
    movies = Movie.all
    render(
      :json => movies.as_json(only: [:id, :title, :overview, :release_date, :inventory]), status: :ok
    )
  end

end
