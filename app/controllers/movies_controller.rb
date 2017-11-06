class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
    else
      render json: {ok: false, errors: {
        id: ["No Movie with ID #{params[:id]} Found"]
        }
      }.as_json, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory]), status: :created
    else
      render json: {ok: false, errors: movie.errors}.as_json, status: :bad_request
    end
  end

  def check
    render json: { message: "it works!" }
  end

private
  #TODO: Possible refactoring method
  # def limited_json
  #   return self.as_json(only: [:title, :overview, :release_date, :inventory])
  # end

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

end
