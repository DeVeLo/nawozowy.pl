class ZwierzetaController < ApplicationController
  before_action :set_zwierze, only: [:show]
  before_action :set_gatunek, only: [:index]

  def index
    render json: @gatunek.zwierzeta.order(name: :ASC)
  end

  def show
    render json: @zwierze
  end

  private
  def set_zwierze
    @zwierze = Zwierze.find(params[:id])
  end

  def set_gatunek
    @gatunek = Gatunek.find(params[:gatunek_id])
  end

end
