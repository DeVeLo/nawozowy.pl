# coding: utf-8
class BilansPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper 

  def initialize(zlecenie)
    @zlecenie = zlecenie
    @rolnik = zlecenie.rolnik
    @instytucja = zlecenie.instytucja
    
    super(:page_size => "A4",
          :page_layout => :portrait,
          :left_margin => 25.0.mm,
          :right_margin => 12.7.mm,
          :top_margin => 12.7.mm,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # nagłówek pisma
    if @zlecenie.typ
      naglowek_a = "Pełny plan nawożenia (azotem, fosforem, potasem, magnezem, wapnowania) na rok gospodarczy " +
                   @zlecenie.name.to_s + " nr " + @zlecenie.nr_zlecenia + " z " + ( l Date.today )
    else
      naglowek_a = "Plan nawożenia azotem na rok gospodarczy " +
                   @zlecenie.name.to_s + " nr " + @zlecenie.nr_zlecenia + " z " + ( l Date.today )
    end
    
    text naglowek_a, size: 8, align: :center, style: :bold

    move_down 5.mm

    # nagłówek pisma
    naglowek

    move_down 5.mm
    
    # dane rolnika i adres ze zlecenia
    Rolnik::Dane.new(self).azotanowy
    
    # dane rolnika i adres ze zlecenia
    # Rolnik::Dane.new(self)

    move_down 8.mm

    table([
            [
              {
                content:  "Najważniejsze informacje o gospodarstwie ", size: 12.pt, font_style: :bold, border_width: 0, padding: 0
              }
            ],
            [
              {
                content: "Liczba roślinopól/działek ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.liczba_roslino_dzialek.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              }
            ],
            [
              { content: "Powierzchnia użytków rolnych ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.suma_powierzchni_uzytkow).to_s + " ha", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia gruntów ornych ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_gruntow_ornych).to_s + " ha", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia użytków zielonych ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_uzytkow_zielonych).to_s + " ha", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia użytków wieloletnich ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_uzytkow_wieloletnich).to_s + " ha", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ]
          ])

    move_down 8.mm
    
    text "Nawozy naturalne w gospodarstwie", size: 12.pt, style: :bold, align: :center


    table([
            [
              {
                content:  "Ilość produkowanych w gospodarstwie ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_obornika.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_obornika_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_gnojowki.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_gnojowki_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_gnojowicy.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_gnojowicy_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])

    table([
            [
              {
                content:  "Ilość zastosowanych ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowany_obornik.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowany_obornik_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowana_gnojowka.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowka_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowana_gnojowica.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowica_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])

    table([
            [
              {
                content:  "Ilość pozostałych do zagospodarowania ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostaly_obornik.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostaly_obornik_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostala_gnojowka.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostala_gnojowka_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostala_gnojowica.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostala_gnojowica_azot.round.to_s, size: 9.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])
    

    
    
    # move_down 3.mm

    # text "Ilość nawozów naturalnych produkowanych w gospodarstwie " + sprintf("%.0f", @zlecenie.produkcja_nawozu).to_s + " ton / w tym "+ sprintf("%.0f", @zlecenie.produkcja_azotu).to_s + " N kg"

    # move_down 3.mm

    # text "Ilość nawozów zastosowanych " + sprintf("%.0f", @zlecenie.ilosc_nawozow_zastosowanych).to_s + " ton / ilość w nich azotu " + sprintf("%.0f", @zlecenie.ilosc_azotu_zastosowanego).to_s + " kg (w tym działającego " + sprintf("%.0f", @zlecenie.ilosc_azotu_dzialajacego).to_s + " kg) "

    # move_down 3.mm

    # text "Ilość pozostałego nawozu " + sprintf("%.0f", @zlecenie.pozostaly_nawoz).to_s + " ton / w tym "+ sprintf("%.0f", @zlecenie.pozostaly_azot).to_s + " N kg"

    # move_down 3.mm


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

  
end
