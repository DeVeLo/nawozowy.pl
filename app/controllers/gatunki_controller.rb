class GatunkiController < ApplicationController
  def index
    render json: Gatunek.all.order(name: :ASC)
  end
end
