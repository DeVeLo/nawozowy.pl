# coding: utf-8
class ZapotrzebowaniePdf < Prawn::Document

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
          :top_margin => 60.mm,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # header
    repeat :all do
      bounding_box [bounds.left, bounds.top + if @zlecenie.typ then 50.mm else 50.mm end], width: bounds.width do

        # nagłówek pisma
        naglowek

        move_down 10.mm

        # if @zlecenie.typ
        #   naglowek_a = "Pełny plan nawożenia\n(azotem, fosforem, potasem, magnezem, wapnowania)\nnr " + @zlecenie.nr_zlecenia +
        #                " na rok gospodarczy " +  @zlecenie.name.to_s
        # else
        #   naglowek_a = "Plan nawożenia azotem nr " + @zlecenie.nr_zlecenia +
        #               " na rok gospodarczy " + @zlecenie.name.to_s
        # end
        
        # text naglowek_a, size: 12.5.pt, align: :center, style: :bold

        text "Zalecane dawki nawozów mineralnych (czysty składnik)\ndo zastosowania dla gospodarstwa w całym roku gospodarczym " +
             @zlecenie.name, size: 12.5.pt, align: :center, style: :bold
        
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
                  if ! @zlecenie.rolnik.ulica.nil? && @zlecenie.rolnik.ulica != '' then ', ' + @zlecenie.rolnik.ulica else ' ' end + ' ' +
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

    move_down 10.mm
    
    @uzytki_table = []
      
    @uzytki_table.push([
                          {
                            content: "Pole", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], font_style: :bold
                          },
                          {
                            content: "Areał (ha)", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], font_style: :bold
                          },
                          {
                            content: "N", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], font_style: :bold
                          },
                          {
                            content: "P<sub>2</sub>O<sub>5</sub>", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], inline_format: true, font_style: :bold
                          },
                          {
                            content: "K<sub>2</sub>O", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], inline_format: true, font_style: :bold
                          },
                          {
                            content: "MgO", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], font_style: :bold
                          },
                          {
                            content: "CaO (t)", width: bounds.width/7, align: :center, border_width: [0, 0, 0.2.mm, 0], font_style: :bold
                          },
                       ]
                     )
      
    
    
    @zlecenie.uzytki.order(lp: :ASC).each do |u|
      @uzytki_table.push([
        {
          content: u.lp.to_s, width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: sprintf("%.2f", u.powierzchnia.round(2)), width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: u.azot_mineralny_pole_w_nawozie.round.to_s, width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: u.fosfor_wynik_pole.to_s, width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: u.potas_wynik_pole.to_s, width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: u.mg_pole.to_s, width: bounds.width/7, align: :center, border_width: 0,
        },
        {
          content: sprintf("%.2f", u.cao_pole.round(2)), width: bounds.width/7, align: :center, border_width: 0,
        },]
      )
    end

    @uzytki_table.push([
        {
          content: "Razem", width: bounds.width/7, align: :center, border_width: [0.2.mm, 0, 0, 0], font_style: :bold
        },
        {
          content: sprintf("%.2f", @zlecenie.suma_powierzchni_uzytkow.round(2)), width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0],  font_style: :bold,
        },
        {
          content: @zlecenie.azot_razem.to_s, width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0], font_style: :bold,
        },
        {
          content: @zlecenie.fosfor_razem.to_s, width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0], font_style: :bold,
        },
        {
          content: @zlecenie.potas_razem.to_s, width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0], font_style: :bold,
        },
        {
          content: @zlecenie.magnez_razem.to_s, width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0], font_style: :bold,
        },
        {
          content: sprintf("%.2f", @zlecenie.cao_razem.round(2)), width: bounds.width/7, align: :center, border_width: 0, border_width: [0.2.mm, 0, 0, 0], font_style: :bold,
        },]
      )
    

    table(@uzytki_table, { header: true })
    
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
