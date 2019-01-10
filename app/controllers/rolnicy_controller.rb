class RolnicyController < ApplicationController
  before_action :set_rolnik, only: [:update, :show, :destroy]
  before_action :set_instytucja

  def index
    respond_to do |f|
      f.html { gon.instytucja_id = @instytucja.id }
      f.json { render json: @instytucja.rolnicy.order(id: :DESC) }
    end
  end

  def show
    render json: @rolnik
  end

  def create
    @rolnik = Rolnik.new(rolnik_params)

    respond_to do |format|
      if @rolnik.save
        format.json { render json: @rolnik, status: :created }
      else
        format.json { render json: @rolnik.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rolnik.update(rolnik_params)
        format.json { render json: @rolnik, status: :ok }
      else
        format.json { render json: @rolnik.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rolnik.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  def rolnik_params
    params.require(:rolnik).permit(:id, :name, :lname, :gname, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc, :nrdom, :nrmieszkania, :nip, :nig, :ulica, :instytucja_id)
  end

  def set_rolnik
    @rolnik = Rolnik.find(params[:id])
  end

  def set_instytucja
    @instytucja = Instytucja.find(params[:instytucja_id])
  end
  
end
