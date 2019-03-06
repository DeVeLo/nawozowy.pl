# coding: utf-8
class UzytekPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper

  def initialize(uzytek)
    @uzytek = uzytek
    @zlecenie = uzytek.zlecenie
    @rolnik = uzytek.zlecenie.rolnik
    
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
    
    # dane użytku
    Uzytek::Uprawa.new(self, @uzytek)
    
    number_pages "(strona <page> z <total>)", height: 20, width: 400, align: :right, at: [bounds.right-400, 0.mm], :start_count_at => 1, size: 10, inline_format: true    
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

  def uzytek
    @uzytek
  end    
  
end
