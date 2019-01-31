class RownowaznikiController < ApplicationController
  before_action :set_rownowaznik, only: [:show, :edit, :update, :destroy]

  # GET /rownowazniki
  # GET /rownowazniki.json
  def index
    @rownowazniki = Rownowaznik.all
  end

  # GET /rownowazniki/1
  # GET /rownowazniki/1.json
  def show
  end

  # GET /rownowazniki/new
  def new
    @rownowaznik = Rownowaznik.new
  end

  # GET /rownowazniki/1/edit
  def edit
  end

  # POST /rownowazniki
  # POST /rownowazniki.json
  def create
    @rownowaznik = Rownowaznik.new(rownowaznik_params)

    respond_to do |format|
      if @rownowaznik.save
        format.html { redirect_to rownowazniki_path, notice: 'Rownowaznik was successfully created.' }
        format.json { render :show, status: :created, location: @rownowaznik }
      else
        format.html { render :new }
        format.json { render json: @rownowaznik.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rownowazniki/1
  # PATCH/PUT /rownowazniki/1.json
  def update
    respond_to do |format|
      if @rownowaznik.update(rownowaznik_params)
        format.html { redirect_to rownowazniki_path, notice: 'Rownowaznik was successfully updated.' }
        format.json { render :show, status: :ok, location: @rownowaznik }
      else
        format.html { render :edit }
        format.json { render json: @rownowaznik.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rownowazniki/1
  # DELETE /rownowazniki/1.json
  def destroy
    @rownowaznik.destroy
    respond_to do |format|
      format.html { redirect_to rownowazniki_url, notice: 'Rownowaznik was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rownowaznik
      @rownowaznik = Rownowaznik.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rownowaznik_params
      params.require(:rownowaznik).permit(:gatunek_id, :nazwautrzymania_id, :sezon_id, :wartosc, :wariant)
    end
end
