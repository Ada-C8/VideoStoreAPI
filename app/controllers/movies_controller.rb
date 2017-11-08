class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render :json => movies, :each_serializer => CustomSerializerSerializer
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie, status: :ok
    else
      render json: { ok: false }, status: :not_found
    end
  end

  def create
    # movie = Movie.create(movie_params)
    movie = Movie.create(title: params[:movie][:title], overview: params[:movie][:overview], release_date: params[:movie][:release_date], inventory: params[:movie][:inventory])
    puts "IN MOVIE CONTROLLER: #{movie} | #{movie.valid?}"

    if movie.valid?
      render(
        json: movie,
        status: :created
      )
    else
      render json: {errors: movie.errors.messages}, status: :bad_request
    end
  end

  private

  # def movie_params
  #   params.require(:movie).permit(:id, :title, :overview, :release_date, :inventory)
  # end
end
