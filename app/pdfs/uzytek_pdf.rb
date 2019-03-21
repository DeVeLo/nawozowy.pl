# coding: utf-8
class UzytekPdf < Prawn::Document

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper 

  def initialize(uzytek)
    @uzytek = uzytek
    @zlecenie = uzytek.zlecenie
    @rolnik = uzytek.zlecenie.rolnik
    
    super(:page_size => "A4",
          :page_layout => if @zlecenie.typ then :landscape else :portrait end,
          :left_margin => if @zlecenie.typ then 12.7.mm else 28.0.mm end,
          :right_margin => 12.7.mm,
          :top_margin => if @zlecenie.typ then 28.mm else 12.7.mm end,
          :bottom_margin => 12.7.mm)

    # ustawienie fontów
    Defaults::Fonts.new(self)

    # header
    # repeat :all do
    #   bounding_box [bounds.left, bounds.top + if @zlecenie.typ then 44.mm else 44.mm end], width: bounds.width do

        # nagłówek pisma
        naglowek

        move_down 10.mm

        if @zlecenie.typ
          naglowek_a = "Pełny plan nawożenia (azotem, fosforem, potasem, magnezem, wapnowania) nr " + @zlecenie.nr_zlecenia +
                       " na rok gospodarczy " +  @zlecenie.name.to_s
        else
          naglowek_a = "Plan nawożenia azotem nr " + @zlecenie.nr_zlecenia +
                      " na rok gospodarczy " + @zlecenie.name.to_s
        end
        
        text naglowek_a, size: 12.5.pt, align: :center, style: :bold

    #   end
    # end

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

    
    move_down 10.mm
    
    # dane użytku
    if @zlecenie.typ
      Uzytek::Pelny.new(self, @uzytek)
    else
      Uzytek::Azotanowy.new(self, @uzytek)
    end
    
    number_pages "(strona <page> z <total>)", height: 20, width: 400, align: :right, at: [bounds.right-400, 0.mm], :start_count_at => 1, size: 10, inline_format: true    
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

  def uzytek
    @uzytek
  end    
  
end
