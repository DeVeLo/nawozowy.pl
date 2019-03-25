class NawozynaturalneController < ApplicationController
  before_action :set_nawoznaturalny, only: [:show, :update, :destroy]
  before_action :set_instytucja
  before_action :set_rolnik
  before_action :set_zlecenie
  before_action :set_uzytek

  def index
    render json: @uzytek.nawozynaturalne.order(created_at: :ASC)
  end

  def show
    render json: @nawoznaturalny
  end
  
  def create
    @nawoznaturalny = @uzytek.nawozynaturalne.new(nawoznaturalny_params)

    respond_to do |format|
      if @nawoznaturalny.save
        format.json { render json: @nawoznaturalny, status: :created }
      else
        format.json { render json: @nawoznaturalny.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @nawoznaturalny.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  def set_nawoznaturalny
    @nawoznaturalny = Nawoznaturalny.find(params[:id])
  end

  def set_instytucja
    @instytucja = Instytucja.find(params[:instytucja_id])
  end

  def set_rolnik
    @rolnik = Rolnik.find(params[:rolnik_id])
  end

  def set_zlecenie
    @zlecenie = Zlecenie.find(params[:zlecenie_id])
  end

  def set_uzytek
    @uzytek = Uzytek.find(params[:uzytek_id])
  end

  def nawoznaturalny_params
    params.require(:nawoznaturalny).permit(:id, :instytucja_id, :rolnik_id, :zlecenie_id, :uzytek_id,
                                           :ilosc, :sezon_id, :animalgroup_id, :sposob, :produkcja, :n)
  end
  
  
end
