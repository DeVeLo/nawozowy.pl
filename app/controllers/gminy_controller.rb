class GminyController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Powiat.find(params[:powiat_id]).gminy }
    end
  end
end
