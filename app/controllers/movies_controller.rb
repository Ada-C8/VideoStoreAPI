class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:title, :overview, :release_date, :inventory]), status: :ok
  end

  def show
  end

  def create
  end

  def check
    render json: { message: "it works!" }
  end
end
