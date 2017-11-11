class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render json: {ok: false, error: "No Movie with that ID"}, status: :not_found
    end

  end

  def create
    movie = Movie.create(movie_params)
    if movie.save
      render json: movie, status: :ok
    else
      render json: { errors: movie.errors.messages},
      status: :bad_request
    end
  end

  private

def movie_params
  params.permit(:title, :release_date, :overview, :inventory, :available_inventory)
end

end
