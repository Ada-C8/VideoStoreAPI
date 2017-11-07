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
      :json => movies.as_json(only: [:id, :title, :release_date]), status: :ok
    )
  end

end
