class MovieController < ApplicationController
  def index
    movies = Movie.all
    render(
      json: movies.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
    )
  end

  def show
  end

  def create
  end

  def update
  end
end
