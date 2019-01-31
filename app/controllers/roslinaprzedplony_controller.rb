class RoslinaprzedplonyController < ApplicationController
  def index
    render json: Roslinaprzedplon.all.order(id: :ASC)
  end
end
