# coding: utf-8
class UzytkiPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper 

  def initialize(zlecenie)
    
    @zlecenie = zlecenie

    
    
    super(:page_size => "A4",
          :page_layout => if @zlecenie.typ then :landscape else :portrait end,
          :left_margin => 35.0.mm,
          :right_margin => 12.7.mm,
          :top_margin => if @zlecenie.typ then 50.mm else 60.mm end,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # header
    repeat :all do
      bounding_box [bounds.left, bounds.top + if @zlecenie.typ then 44.mm else 54.mm end], width: bounds.width do

        if @zlecenie.typ
          naglowek_a = "Pełny plan nawożenia (azotem, fosforem, potasem, magnezem, wapnowania) na rok gospodarczy " +
                       @zlecenie.name.to_s + " nr " + @zlecenie.nr_zlecenia + " z " + ( l Date.today )
        else
          naglowek_a = "Plan nawożenia azotem na rok gospodarczy " +
                       @zlecenie.name.to_s + " nr " + @zlecenie.nr_zlecenia + " z " + ( l Date.today )
        end
        
        text naglowek_a, size: 9, align: :center, style: :bold

        move_down 5.mm

        # nagłówek pisma
        naglowek

        move_down 5.mm
        
        # dane rolnika i adres ze zlecenia
        if @zlecenie.typ
          Rolnik::Dane.new(self).pelny
        else
          Rolnik::Dane.new(self).azotanowy
        end
      end
    end

    move_down 5.mm
    
    zlecenie.uzytki.order(created_at: :ASC).each_with_index do |uzytek, index|
      # dane użytku
    if @zlecenie.typ
      Uzytek::Pelny.new(self, uzytek)
    else
      Uzytek::Azotanowy.new(self, uzytek)
    end

      if ((index + 1) < zlecenie.uzytki.count)
        move_down 15.pt
    #    stroke_horizontal_rule
    #    move_down 15.pt
      end
    end

    move_down 15.pt
    
	 text 'Dawki azotu zostały opracowane w oparciu o Dz.U.2018 poz.1339., zgodnie z zadeklarowanym plonem oraz pobraniem składników pokarmowych przez rośliny na wytworzenie jednostki plonu.

Wyliczone dawki nawozów mineralnych zostały podane w czystym składniku i powinny zostać zastosowane w dawkach podzielonych dostosowanych do pory roku i fazy rozwojowej rośliny.'
    
    number_pages "(strona <page> z <total>)", height: 20, width: 400, align: :right, at: [bounds.right-400, -5.mm], :start_count_at => 1, size: 10, inline_format: true    
end

  # nagłówek
  def naglowek
    # dane instytucji
    table([
            [
              Instytucja::Title.new(self).firma,
            ]
          ],
          {
            width: bounds.width,
          } )
  end

  # methods for children classes
  def zlecenie
    @zlecenie
  end
  
end
