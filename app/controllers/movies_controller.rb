class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render(
      json: movies.as_json(only: [:id, :title, :release_date]),
      status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render(
        json: movie.as_json(only: [:age, :id, :human, :name]),status: :ok
      )
    else
      render(
        json: { ok: false },
        status: :not_found
      )
    end
  end

  def create
  end

  private
    def movie_params
      params.require(:movie).permit(:id, :title, :release_date, :overview, :inventory, :available_inventory)
    end
end
