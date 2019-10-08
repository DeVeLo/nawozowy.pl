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
          :top_margin => if @zlecenie.typ then 60.mm else 50.0.mm end,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # header
    repeat :all do
      bounding_box [bounds.left, bounds.top + if @zlecenie.typ then 54.mm else 44.mm end], width: bounds.width do

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
                  if ! @zlecenie.rolnik.ulica.nil? && @zlecenie.rolnik.ulica != '' then ', ' + @zlecenie.rolnik.ulica + ' ' else ' ' end +
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

    if @zlecenie.animals.count > 0
      text "Nawozy naturalne w gospodarstwie", size: 12.pt, style: :bold, align: :center

      nawoz = Bilans::Nawozy.new(self)

      def nawoz_table(title, method, nawoz, dzialajacy = nil, allow_push = false)
        tab = []
        flag = allow_push
        
        tab.push(
          nawoz.naglowek(title + " ",
                         "ton nawozu",
                         "kg N",
                         if dzialajacy != nil
                           "kg N działającego"
                         else
                           nil
                         end))
        
        [
          {t: 'Obornik ',  n: 'obornik',   m: method[:meski],  nid: [1,2]},
          {t: 'Gnojówka ', n: 'gnojowka',  m: method[:zenski], nid: 3},
          {t: 'Gnojowica', n: 'gnojowica', m: method[:zenski], nid: 4}
        ].each do |n|
          if @zlecenie.send("#{n[:m]}_#{n[:n]}").round > 0 || allow_push
            flag = true
            tab.push(
              nawoz.zagregowany(
                n[:t],
                @zlecenie.send("#{n[:m]}_#{n[:n]}"),
                @zlecenie.send("#{n[:m]}_#{n[:n]}_azot"),
                if dzialajacy != nil then @zlecenie.send("#{n[:m]}_#{n[:n]}_azot_dzialajacy") else nil end,
                allow_push
              )
            )

            if method[:meski] == 'produkcja' || method[:meski] == 'zakupiony'
              @zlecenie.
                animals.
                send(method[:meski]).
                where(nazwautrzymania_id: n[:nid]).
                each do |animal|
                
                tab.push(
                  nawoz.szczegolowy(
                    if method[:meski] == 'produkcja' then animal.name else animal.animalgroup.nazwaglowny end,
                    animal.produkt,
                    animal.azot
                  )
                )
                
              end
            end

            if method[:meski] == 'zastosowany'
              @zlecenie.
                animalgroups.
                joins(:animals).
                where(animals: { nazwautrzymania_id: n[:nid] }).
                distinct.
                each do |group|

                if (group.produkt - group.pozostalynawoz).round > 0
                  tab.push(
                    nawoz.szczegolowy(
                      group.nazwaglowny,
                      group.produkt - group.pozostalynawoz,
                      group.produkcja_azot - group.pozostaly_azot,
                      (group.produkcja_azot - group.pozostaly_azot) * 0.7,
                    )
                  )
                end
                
              end
            end

            if method[:meski] == 'pozostaly' # || method[:meski] == 'zakupiony'
              @zlecenie.
                animalgroups.
                joins(:animals).
                where(animals: { nazwautrzymania_id: n[:nid] }).
                distinct.
                each do |group|

                puts '&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
                puts group.nazwaglowny
                puts '&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'

                if  group.pozostalynawoz.round > 0
                  tab.push(
                    nawoz.szczegolowy(
                      group.nazwaglowny,
                      group.pozostalynawoz,
                      group.pozostaly_azot
                    )
                  )
                end
                
              end
            end
            
          end
        end
        if flag
          table(tab)
        end
      end
      
      nawoz_table("Produkowane w gospodarstwie", {meski: "produkcja", zenski: "produkcja"}, nawoz, nil)
      nawoz_table("Nabyte", {meski: "zakupiony", zenski: "zakupiona"}, nawoz, nil)
      nawoz_table("Zastosowane na polach gospodarstwa", {meski: "zastosowany", zenski: "zastosowana"}, nawoz, true)
      nawoz_table("Pozostałe do zagospodarowania", {meski: "pozostaly", zenski: "pozostala"}, nawoz, nil)

    end
      
    # jeśli zaznaczono w edycji zleceni że bilans ma się wyświetlać
    if @zlecenie.bilansn == true
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
    end

    

    if ! @zlecenie.nil? && @zlecenie.uwagi != ''
    
      move_down 5.mm
    
      text "Uwagi.", size: 12.pt, style: :normal
      
      move_down 2.mm
    
      text @zlecenie.uwagi, size: 11.pt, style: :italic, inline_format: true, align: :justify

    end

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
    image = Rails.root.join('public',@zlecenie.instytucja.logo).to_s
    table([
            [
              {
                :image => image, :fit => [50, 100],
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
