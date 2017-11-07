class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
    else
      render json: { errors: {id: "#{params[:id]} not found"} }, status: :not_found
    end
  end

  def create
    puts movie_params
    movie = Movie.new movie_params

    if movie.save
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]),
      status: :created
    else
      render json: { errors: movie.errors.messages }, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
