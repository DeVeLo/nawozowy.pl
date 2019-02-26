# coding: utf-8
class UzytkiPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper

  def initialize(zlecenie)
    @zlecenie = zlecenie
    
    super(:page_size => "A4",
          :page_layout => :landscape,
          :left_margin => 12.7.mm,
          :right_margin => 12.7.mm,
          :top_margin => 7.6.mm,
          :bottom_margin => 7.6.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # nagłówek pisma
    naglowek

    move_down 10.mm
    
    # dane rolnika i adres ze zlecenia
    Rolnik::Dane.new(self)

    move_down 5.mm

    zlecenie.uzytki.order(created_at: :ASC).each_with_index do |uzytek, index|
      # dane użytku
      Uzytek::Uprawa.new(self, uzytek)

      if ((index + 1) < zlecenie.uzytki.count)
        move_down 15.pt
        stroke_horizontal_rule
        move_down 15.pt
      end
    end
  end

  # nagłówek
  def naglowek
    # dane instytucji
    table([
            [ { content: '', border_width: 0, width: 60.mm },
              Instytucja::Title.new(self).firma,
              { content: '', border_width: 0  }
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
