class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      show_movie_hash = {
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
        available_inventory: movie.available_inventory,
      }

      render json: show_movie_hash.as_json, status: :ok
    else
      render json: { ok: false }, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:id]), status: :created
    else
      render json: { ok: false }, status: :bad_request
    end  end

  private
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
