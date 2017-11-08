class MoviesController < ApplicationController
  def index
    accepted_params = %w(title release_date)
    if accepted_params.include?(params[:sort])
      movies = Movie.all.order(params[:sort].to_sym)
    else
      movies = Movie.all.order(:id)
    end
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render json: { errors: {id: "#{params[:id]} not found"} }, status: :not_found
    end
  end

  def create
    movie = Movie.new movie_params

    if movie.save
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]),
      status: :ok
    else
      render json: { errors: movie.errors.messages }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
