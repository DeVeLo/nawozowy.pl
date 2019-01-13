class WariantyController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Wariant.all }
    end
  end
end
