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
    :json => movies.as_json(only: [:id, :title, :release_date]),
    status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render(
      :json => movie.as_json(only: [:title, :overview, :release_date, :inventory]),
      status: :ok
      )
    else
      render(
      json: {id: "Invalid Movie ID"},
      status: :not_found
      )
    end
  end

end
