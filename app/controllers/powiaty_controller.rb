class PowiatyController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Wojewodztwo.find(params[:wojewodztwo_id]).powiaty.order(name: :ASC) }
    end
  end
end
