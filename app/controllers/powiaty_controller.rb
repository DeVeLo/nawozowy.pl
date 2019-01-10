class PowiatyController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Wojewodztwo.find(params[:wojewodztwo_id]).powiaty }
    end
  end
end
