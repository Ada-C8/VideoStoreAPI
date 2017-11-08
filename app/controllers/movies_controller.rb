class MoviesController < ApplicationController

# this action will return a list of all the movies in the api response
  def index
    movies = Movie.all
    render(
      json: movies.as_json(only: [:id, :title, :overview, :release_date, :inventory]),
      status: :ok
    )
  end

# this action will return information for a sinlge instance of Movie in the api request
  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render(
        json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory], methods: [ :available_inventory]),
        status: :ok
      )
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end


  end

# this action allows a new instance of Movie to be created by the user of the api
  def create
    movie = Movie.new(movie_params)

    if movie.save
      render(
        json: {id: movie.id}, status: :ok
      )
    else
      render(
        json: {errors: movie.errors.messages}, status: :bad_request
      )
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
