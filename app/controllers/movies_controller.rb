class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render(
      json: movies.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render(
        json: movie.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
      )
    else
      render(
        json: { "nothing" => true}, status: :not_found
      )
    end
  end

  def create
    movie = Movie.new(movies_params)
    if movie.save!
      # This is returning the new movie id as a json back to the user
      render json: { id: movie.id }, status: :ok
    else
      # If there was an error with one of the validations then we are sending back a json hash with the errors as an array?
      render json: { errors: movie.errors.messages }, status: :bad_request
    end
  end

  def update
  end

  private

  def movies_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
