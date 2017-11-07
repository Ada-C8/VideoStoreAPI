class MoviesController < ApplicationController

  def index
    movies = Movie.all

    #ensureing all the movie records are formated in json with the specific categories
    render(
      json: movies.as_json(only: [:id, :release_date, :title]),
      status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render(
        json: movie.as_json(only: [:id, :name, :age, :human]),
        status: :ok
      )
    else
      render(
        json: { nothing: true },
        status: :not_found
      )
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render(
        json: {id: movie.id},
        status: :ok
      )
    else
      render(
        json: { errors: movie.errors.messages },
        status: :bad_request
      )
    end

  end


  private

  def movie_params
    params.require(:movie).permit(:title, :release_date)
  end
end
