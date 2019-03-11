class RolnicyController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_rolnik, only: [:update, :show, :destroy]
  before_action :set_instytucja

  def index    
    respond_to do |f|
      f.html { gon.instytucja_id = @instytucja.id }
      f.json { render json: @instytucja.rolnicy.accessible_by(current_ability).order(id: :DESC) }
    end
  end

  def show
    render json: @rolnik
  end

  def create
    @rolnik = @instytucja.rolnicy.accessible_by(current_ability).new(rolnik_params)

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
    params.require(:rolnik).permit(:id, :name, :lname, :gname, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc, :nrdom, :nrmieszkania, :nip, :nig, :ulica, :instytucja_id, :kod, :poczta, :tel, :kom, :mail)
  end

  def set_rolnik
    @rolnik = Rolnik.find(params[:id])
  end

  def set_instytucja
    if (current_user.role? :specjalista and params[:instytucja_id] == current_user.instytucja_id) or current_user.role? :admin
      @instytucja = Instytucja.find(params[:instytucja_id])
    elsif (current_user.role? :specjalista and params[:instytucja_id] != current_user.instytucja_id)
      redirect_to instytucja_rolnicy_path(instytucja_id: current_user.instytucja_id)
    else
      redirect_to zabroniony_path
    end
  end
  
end
