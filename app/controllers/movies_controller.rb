class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render(
      json: movies.as_json(only: [:title, :overview, :release_date, :inventory],
      status: :ok)
    )
  end
  def show
    movie = Movie.find_by_id(params[:id])
    if movie
      render(
      json: movie.as_json(only: [:title, :overview, :release_date, :invetory]), status: :ok )
    else
      render(
      json: {nothing: true}, status: :not_found
      )
    end
  end
  def create
  end
end
