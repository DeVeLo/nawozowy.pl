class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :update, :destroy]
  before_action :set_instytucja
  before_action :set_rolnik
  before_action :set_zlecenie
  before_action :set_animalgroup

  def index
    render json: @zlecenie.animals.order(created_at: :ASC)
  end

  def show
    render json: @animal
  end
  
  def create
    @animal = @zlecenie.animals.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.json { render json: @animal, status: :created }
      else
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.json { render json: @animal, status: :ok }
      else
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @animal.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  def set_animal
    @animal = Animal.find(params[:id])
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

  def set_animalgroup
    @animalgroup = Animalgroup.find(params[:animalgroup_id])
    logger.info @animalgroup
  end
  
  def animal_params
    params.require(:animal).permit(:id, :instytucja_id, :rolnik_id, :zlecenie_id, :zwierze_id,
                                   :nazwautrzymania_id, :systemutrzymania_id, :sztuk, :specjalnezywienie,
                                   :badania, :zawartosc, :rownowaznik_id, :animalgroup_id,
                                   :fosfor, :potas, :magnez, :wapn, :zrodlo)
  end
end
