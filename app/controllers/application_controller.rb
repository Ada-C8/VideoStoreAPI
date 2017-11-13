class ApplicationController < ActionController::API
  def zomg
    render json: {ok: "it works"}
  end
end
