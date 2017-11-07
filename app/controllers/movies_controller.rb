class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :overview, :inventory, :release_date], :methods => [:available_inventory])
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :title, :overview, :inventory, :release_date], :methods => [:available_inventory])
    else
      render json: { nothing: true }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: {id: movie.id}
    else
      render json: {errors: movie.errors.messages}, status: :bad_request
    end
  end

  private
  def movie_params
    params.permit(:title, :overview, :inventory, :release_date)
  end
end
