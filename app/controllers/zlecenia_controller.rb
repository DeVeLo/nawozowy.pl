class ZleceniaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_zlecenie, only: [:show, :update, :show, :destroy, :destroy_nawozynaturalne, :bilans, :zapotrzebowanie]
  before_action :set_instytucja
  before_action :set_rolnik

  def index
    respond_to do |f|
      f.html {
        gon.instytucja_id = @instytucja.id
        gon.rolnik_id = @rolnik.id
        gon.wojewodztwo_id = @rolnik.wojewodztwo_id
        gon.powiat_id = @rolnik.powiat_id
        gon.gmina_id = @rolnik.gmina_id
        gon.miejscowosc = @rolnik.miejscowosc
      }
      f.json { render json: @rolnik.zlecenia.order(datawplywu: :DESC, lp: :DESC) }
    end
  end

  def show
    respond_to do |f|
      f.html {
        gon.instytucja_id = @instytucja.id
        gon.rolnik_id = @rolnik.id
        gon.id = @zlecenie.id
      }
      f.json {
        render json: @zlecenie
      }
      f.pdf do
        pdf = ZleceniePdf.new(@zlecenie)
        send_data pdf.render,
                  filename: "#{@zlecenie.id}",
                  type: 'application/pdf',
                  disposition: 'download'
      end
    end  
  end       

  def bilans
    respond_to do |f|
      f.pdf do
        pdf = BilansPdf.new(@zlecenie)
        send_data pdf.render,
                  filename: "bilans-#{@zlecenie.id}",
                  type: 'application/pdf',
                  disposition: 'download'
      end
    end
  end

  def zapotrzebowanie
    respond_to do |f|
      f.pdf do
        pdf = ZapotrzebowaniePdf.new(@zlecenie)
        send_data pdf.render,
                  filename: "zapotrzebowanie-#{@zlecenie.id}",
                  type: 'application/pdf',
                  disposition: 'download'
      end
    end
  end
  
  def create
    @zlecenie = @rolnik.zlecenia.new(zlecenie_params)

    respond_to do |format|
      if @zlecenie.save
        format.json { render json: @zlecenie, status: :created }
      else
        format.json { render json: @zlecenie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @zlecenie.update(zlecenie_params)
        format.json { render json: @zlecenie, status: :ok }
      else
        format.json { render json: @zlecenie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @zlecenie.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # usuwa wszystkie nawozy naturalne w zleceniu
  def destroy_nawozynaturalne
    Nawoznaturalny.where(uzytek: @zlecenie.uzytki).destroy_all
    render json: @zlecenie
  end
  
  private
  def zlecenie_params
    params.require(:zlecenie).permit(:id, :name, :wariant_id, :instytucja_id, :rolnik_id,
                                     :sprawa, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc,
                                     :powierzchnia, :podstawa_id, :podstawainna, :datawplywu, :lp,
                                     :rejestr, :typ, :bilansn, :datawydruku, :zmiendatewydruku, :uwagi)
  end
  
  def set_zlecenie
    @zlecenie = Zlecenie.find(params[:id])
  end
  
  def set_rolnik
    @rolnik = Rolnik.find(params[:rolnik_id])
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
