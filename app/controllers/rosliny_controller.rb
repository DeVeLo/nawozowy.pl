class RoslinyController < ApplicationController

  def index
    render json: Roslina.where(rodzajuprawy_id: params[:rodzajeuprawy_id]).all.order(name: :ASC)
  end
  
end
