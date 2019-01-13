class ZwierzetaController < ApplicationController
  before_action :set_gatunek, only: [:index]

  def index
    render json: @gatunek.zwierzeta.order(name: :ASC)
  end

  private
  def set_gatunek
    @gatunek = Gatunek.find(params[:gatunek_id])
  end
end
