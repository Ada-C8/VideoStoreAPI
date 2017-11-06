class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render(
      json: movies.as_json(only: [:id, :title, :release_date]),
      status: :ok
    )
  end

  def show
  end

  def create
  end

  private
    def movie_params
      params.require(:movie).permit(:id, :title, :release_date, :overview, :inventory, :available_inventory)
    end
end
