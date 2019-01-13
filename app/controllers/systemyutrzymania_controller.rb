class SystemyutrzymaniaController < ApplicationController
  before_action :set_nazwautrzymania, only: [:index]
  before_action :set_zwierze, only: [:index]

  def index
    render json: Systemutrzymania.wynik(@zwierze.id, @nazwautrzymania.id)
  end

  private
  def set_zwierze
    @zwierze = Zwierze.find(params[:zwierze_id])
  end

  def set_nazwautrzymania
    @nazwautrzymania = Nazwautrzymania.find(params[:nazwautrzymania_id])
  end
end
