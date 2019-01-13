class NazwyutrzymaniaController < ApplicationController
  before_action :set_zwierze, only: [:index]

  def index
    render json: @zwierze.nazwyutrzymania.order(name: :ASC)
  end

  private
  def set_zwierze
    @zwierze = Zwierze.find(params[:zwierze_id])
  end
  
end
