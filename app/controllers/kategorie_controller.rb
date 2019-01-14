class KategorieController < ApplicationController

  def index
    render json: Kategoria.all.order(id: :ASC)
  end
  
end
