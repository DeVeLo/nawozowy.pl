# coding: utf-8
class ZleceniePdf < Prawn::Document

  include ActionView::Helpers::NumberHelper

  def initialize(zlecenie)
    super(:page_size => "A4",
          :page_layout => :portrait,
          :left_margin => 12.7.mm,
          :right_margin => 12.7.mm,
          :top_margin => 7.6.mm,
          :bottom_margin => 7.6.mm)

    @zlecenie = zlecenie
    
    # ustawienia fontów podstawowych
    Zlecenie::Preparation.new(self)

    # pisz nagłówek (po lewej rolnik po prawej instytucja)
    Zlecenie::Title.new(self)

    # pisz zlecenie
    pisz_zlecenie

    # pisz gospodarstwo rolne zleca ...
    Zlecenie::Podstawaw.new(self)

    # położenie gruntów
    Zlecenie::Polozenie.new(self)
    
  end

  # method for children classes
  def zlecenie
    @zlecenie
  end

  # tekst ZLECENIE na środku
  def pisz_zlecenie
    move_down 50.pt
    text "ZLECENIE", align: :center, style: :bold, size: 14.pt
  end

end
