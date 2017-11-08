class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render(
      json: movies.to_json(only: [:id, :title, :release_date]),
      status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render(
        json: movie.as_json(only: [:title, :overview, :release_date, :inventory]).merge("available_inventory" => movie.available_inventory),
        status: :ok
      )
    else
      render(
        json: {
          "ok" => false,
          "errors" => {
            "id": ["Could not find movie with id: #{params[:id]}"]
          }
        },
        status: :not_found
      )
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render(
        json: movie.as_json(only: [:id]),
        status: :ok
      )
    else
      render(
        json: {
          "ok" => false,
          "errors" => movie.errors.messages
        },
        status: :bad_request) #400 response code
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date)
  end

end
