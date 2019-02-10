class PodstawyController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Podstawa.all }
    end
  end
end
