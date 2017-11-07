class MoviesController < ApplicationController

  def index
    movies = Movie.all

    #ensureing all the movie records are formated in json with the specific categories
    render(
      json: movies.as_json(only: [:inventory, :overview, :release_date, :title]),
      status: :ok
    )
  end
end
