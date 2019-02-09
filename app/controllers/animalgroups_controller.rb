class AnimalgroupsController < ApplicationController
  before_action :set_animalgroup, only: [:show, :update, :destroy]
  before_action :set_instytucja
  before_action :set_rolnik
  before_action :set_zlecenie

  def index
    render json: @zlecenie.animalgroups.order(created_at: :ASC)
  end

  def show
    render json: @animalgroup
  end
  
  def create
    @animalgroup = @zlecenie.animalgroups.new(animalgroup_params)

    respond_to do |format|
      if @animalgroup.save
        format.json { render json: @animalgroup, status: :created }
      else
        format.json { render json: @animalgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @animalgroup.update(animalgroup_params)
        format.json { render json: @animalgroup, status: :ok }
      else
        format.json { render json: @animalgroup.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @animalgroup.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  def set_animalgroup
    @animalgroup = Animalgroup.find(params[:id])
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
  
  def animalgroup_params
    params.require(:animalgroup).permit(:id, :name, :instytucja_id, :rolnik_id, :zlecenie_id)
  end

end
