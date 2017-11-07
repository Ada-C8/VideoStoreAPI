class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.to_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory]), status: :ok
    else
      render json: {ok: false, message: "No Movie with that ID"}, status: :not_found
    end

  end

  def create
    movie = Movie.create(movie_params)
    if movie.save
      render json: movie.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory]), status: :created
    else
      render json: { errors: movie.errors.messages},
      status: :bad_request
    end
  end




  private

def movie_params
  params.require(:movie).permit(:id, :title, :release_date, :overview, :inventory, :available_inventory)
end

end
