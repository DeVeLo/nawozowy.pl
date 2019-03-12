# coding: utf-8
class BilansPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper

  def initialize(zlecenie)
    @zlecenie = zlecenie
    @rolnik = zlecenie.rolnik
    @instytucja = zlecenie.instytucja
    
    super(:page_size => "A4",
          :page_layout => :portrait,
          :left_margin => 12.7.mm,
          :right_margin => 12.7.mm,
          :top_margin => 12.7.mm,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # nagłówek pisma
    
    
    # dane rolnika i adres ze zlecenia
    # Rolnik::Dane.new(self)

    move_down 5.mm
    
    # dane użytku
    
    
    number_pages "(strona <page> z <total>)", height: 20, width: 400, align: :right, at: [bounds.right-400, 0.mm], :start_count_at => 1, size: 10, inline_format: true    
  end

end
