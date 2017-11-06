class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render(
      json: movies.to_json(only: [:id, :title, :release_date])
    )
  end

end
