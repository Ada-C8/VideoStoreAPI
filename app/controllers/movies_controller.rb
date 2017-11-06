class MoviesController < ApplicationController

  def index
  end

  def show
  end

  def create
  end

  def check
    render json: { message: "it works!" }
  end
end
