class UzytkiController < ApplicationController
  before_action :set_uzytek, only: [:show, :update, :destroy]
  before_action :set_instytucja
  before_action :set_rolnik
  before_action :set_zlecenie

  def index
    respond_to do |f|
      f.json { render json: Uzytek.all.where(zlecenie_id: @zlecenie.id).order(created_at: :ASC) }
      f.pdf {
        pdf = UzytkiPdf.new(@zlecenie)
        send_data pdf.render,
                  filename: "#{@zlecenie.id}-uzytki.pdf",
                  type: 'application/pdf',
                  disposition: 'download'
      }
    end
  end

  def show
    respond_to do |f|
      f.json { render json: @uzytek }
      f.pdf {
        pdf = UzytekPdf.new(@uzytek)
        send_data pdf.render,
                  filename: "#{@zlecenie.id}-#{@uzytek.id}.pdf",
                  type: 'application/pdf',
                  disposition: 'download'
      }
    end
  end

  def create
    @uzytek = @zlecenie.uzytki.new(uzytek_params)

    respond_to do |f|
      if @uzytek.save
        f.json { render json: @uzytek, status: :created }
      else
        f.json { render json: @uzytek.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @uzytek.update(uzytek_params)
        format.json { render json: @uzytek, status: :ok }
      else
        format.json { render json: @uzytek.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @uzytek.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private
  def set_uzytek
    @uzytek = Uzytek.find(params[:id])
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
  
  def uzytek_params
    params.require(:uzytek).permit(:id, :instytucja_id, :rolnik_id, :zlecenie_id,
                                   :name, :kategoria_id, :rodzajuprawy_id, :nmin,
                                   :prognoza, :badania, :bobowata_id, :roslina_id,
                                   :plon, :powierzchnia, :nminsezon, :przedplon,
                                   :roslinaprzedplon_id,
                                   nawozynaturalne_attributes: [:id, :uzytek_id, :produkcja, :ilosc,
                                                                :n, :animalgroup_id, :sezon_id, :_destroy])
  end
end
