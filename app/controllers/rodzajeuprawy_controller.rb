class RodzajeuprawyController < ApplicationController

  def index
    render json: Rodzajuprawy.all.order(name: :ASC)
  end
  
end
