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
          :left_margin => 28.0.mm,
          :right_margin => 12.7.mm,
          :top_margin => 50.0.mm,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # header
    repeat :all do
      bounding_box [bounds.left, bounds.top + if @zlecenie.typ then 44.mm else 44.mm end], width: bounds.width do

        # nagłówek pisma
        naglowek

        move_down 10.mm

        if @zlecenie.typ
          naglowek_a = "Pełny plan nawożenia\n(azotem, fosforem, potasem, magnezem, wapnowania)\nnr " + @zlecenie.nr_zlecenia +
                       " na rok gospodarczy " +  @zlecenie.name.to_s
        else
          naglowek_a = "Plan nawożenia azotem nr " + @zlecenie.nr_zlecenia +
                      " na rok gospodarczy " + @zlecenie.name.to_s
        end
        
        text naglowek_a, size: 12.5.pt, align: :center, style: :bold

      end
    end
    
    move_down 10.mm
    
    # dane rolnika i adres ze zlecenia
    table([
            [
              { content: "Dane zleceniodawcy:",
                size: 12.pt,
                font_style: :bold,
                border_width: 0,
                padding: 0
              }
            ],
            [
              {
                content: @zlecenie.rolnik.gname,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
                width: bounds.width
              },
            ],
            [
              {
                content: @zlecenie.rolnik.miejscowosc +
                  if ! @zlecenie.rolnik.ulica.nil? && @zlecenie.rolnik.ulica != '' then ', ' + @zlecenie.rolnik.ulica else ' ' end +
                  @zlecenie.rolnik.nrdom.to_s +
                if ! @zlecenie.rolnik.nrmieszkania.nil? && @zlecenie.rolnik.nrmieszkania != '' then '/' + @zlecenie.rolnik.nrmieszkania.to_s else '' end,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
                width: bounds.width
              },
            ],
            [
              {
                content: @zlecenie.rolnik.kod + ' ' + @zlecenie.rolnik.poczta,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
                width: bounds.width
              },
            ],
            [
              {
                content: 'NIG: ' + @zlecenie.rolnik.nig,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
                width: bounds.width
              },
            ],
          ])

    move_down 8.mm

    # położenie gospodarstwa
    table([
            [
              { content: "Położenie gruntów:",
                size: 12.pt,
                font_style: :bold,
                border_width: 0,
                padding: 0,
              }
            ],
            [
              {
                content: "Miejscowość:",
                padding: 0,
                size: 11.pt,
                border_width: 0
              },
              {
                content: if ! @zlecenie.miejscowosc.nil? && @zlecenie.miejscowosc != '' then @zlecenie.miejscowosc else '' end,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
              },
            ],
            [
              {
                content: "Gmina:",
                padding: 0,
                size: 11.pt,
                border_width: 0
              },
              {
                content: @zlecenie.gmina.name,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
              },
            ],
            [
              {
                content: "Powiat:",
                padding: 0,
                size: 11.pt,
                border_width: 0
              },
              {
                content: @zlecenie.powiat.name,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
              },
            ],
            [
              {
                content: "Województwo:",
                padding: 0,
                size: 11.pt,
                border_width: 0
              },
              {
                content: @zlecenie.wojewodztwo.name,
                size: 11.pt,
                font_style: :normal,
                border_width: 0,
                padding: [0.5.mm, 0, 0, 0],
              },
            ],
          ])
    
    move_down 8.mm
    
    table([
            [
              {
                content:  "Najważniejsze informacje o gospodarstwie ", size: 12.pt, font_style: :bold, border_width: 0, padding: 0
              }
            ],
            [
              {
                content: "Liczba roślinopól/działek ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.liczba_roslino_dzialek.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              }
            ],
            [
              { content: "Powierzchnia użytków rolnych ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.suma_powierzchni_uzytkow).to_s + " ha", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia gruntów ornych ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_gruntow_ornych).to_s + " ha", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia użytków zielonych ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_uzytkow_zielonych).to_s + " ha", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ],
            [
              { content: "Powierzchnia użytków wieloletnich ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 },
              { content: sprintf("%.2f", @zlecenie.powierzchnia_uzytkow_wieloletnich).to_s + " ha", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2 }
            ]
          ])

    move_down 8.mm
    
    text "Nawozy naturalne w gospodarstwie", size: 12.pt, style: :bold, align: :center


    table([
            [
              {
                content:  "Produkowane w gospodarstwie ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_obornika.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_obornika_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_gnojowki.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_gnojowki_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.produkcja_gnojowicy.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.produkcja_gnojowicy_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])

    table([
            [
              {
                content:  "Zastosowane na polach gospodarstwa ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N działającego", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowany_obornik.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowany_obornik_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowany_obornik_azot_dzialajacy.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowana_gnojowka.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowka_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowka_azot_dzialajacy.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.zastosowana_gnojowica.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowica_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.zastosowana_gnojowica_azot_dzialajacy.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])

    table([
            [
              {
                content:  "Pozostałe do zagospodarowania ", size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: "ton nawozu", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: "kg N", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Obornik ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostaly_obornik.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostaly_obornik_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojówka ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostala_gnojowka.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostala_gnojowka_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
            [
              {
                content: "Gnojowica ", size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.pozostala_gnojowica.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
              {
                content: @zlecenie.pozostala_gnojowica_azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              }
            ],
          ])
    

    table([
            [
              {
                content:  "Średni bilans azotu w gospodarstwie ", size: 12.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2
              },
              {
                content: @zlecenie.sredni_bilans.round.to_s, size: 12.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: bounds.width/2/3
              },
            ]
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

  def instytucja
    [
      [
        {
          content: @instytucja.name,
          width: bounds.width/10*5,
          border_width: 0,
          padding: 0,
          height: 40.mm,
          size: 10.pt,
          font_style: :bold,
        }
      ]
    ]
  end
  
  # nagłówek
  def naglowek
    # dane instytucji
    table([
            [
              {
                border_width: 0,
                padding: 0,
                width: bounds.width/4
              },
              Instytucja::Title.new(self).firma(bounds.width/2),
              {
                content: @zlecenie.instytucja.miejscowosc +
                ', ' + if @zlecenie.zmiendatewydruku && ! @zlecenie.datawydruku.nil? then (l @zlecenie.datawydruku) else (l Date.today) end + ' r.',
                width: bounds.width/4,
                border_width: 0,
                padding: 0,
                align: :right,
              }
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
