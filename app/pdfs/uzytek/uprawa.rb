# coding: utf-8
class Uzytek::Uprawa

  def initialize(o, uzytek)

    @o = o
    @uzytek = uzytek
    @rolnik = uzytek.rolnik
    @zlecenie = uzytek.zlecenie

    @uprawa = []
    uprawa
    przedplon
    bobowata
    
    @o.table([
               [
                 { content: ogolne,
                   border_width: 0.2.mm,
                   width: @o.bounds.width },
               ],
               [
                 { content: wyniki,
                   border_width: [ 0, 0.2.mm, 0.2.mm, 0.2.mm ] },
               ],
               [
                 { content: podsumowanie,
                   border_width: [ 0, 0.2.mm, 0.2.mm, 0.2.mm ] },
               ],
             ])

    @o.move_down 15.pt

    @o.text 'Azot stosujemy z podziałem na dawki.'

    @o.move_down 15.pt


    if @uzytek.nawozywykorzystane.count > 0
      @o.text 'Zastosowany nawóz naturalny pod roślinę:'
    end

    lp = 0
    @uzytek.nawozywykorzystane.each do |nw|
      lp = lp + 1
      @o.text ++lp.to_s + ') ' + nw.animal.nazwautrzymania.name + ' - ' + nw.animal.name + ' - ' + nw.ilosc_na_pole.round(0).to_i.to_s + ' t/pole - ' + nw.nawoznaturalny.sezon.name
      #zanimalsami += (nw.ilosc * nw.animal.zawartosc_wynikowa * nw.animal.getrownowaznik(nw.nawoznaturalny.sezon_id))
    end

    @o.move_down 15.pt
    
	 @o.text 'Ilość azotu działającego z nawozu naturalnego + z pozostałych źródeł ' + @uzytek.zanimalsami.round(0).to_i.to_s + ' kg N/ha'
    
    
  end

  # podsumowanie
  def podsumowanie
    [
      [
        { content: 'Nawożenie azotem (kg N/ha/rok): <b>' + @uzytek.azot.round(0).to_i.to_s + "</b> " +
          "(z nawozów mineralnych " + @uzytek.azot_mineralny_ha_w_nawozie.round(0).to_i.to_s + ", z nawozów nat. i organicznych " +
          @uzytek.nawoznaturalny.round(0).to_i.to_s + ")", border_width: 0, inline_format: true, padding: [ 1.mm, 1.mm, 1.mm, 2.mm ], width: @o.bounds.width/3*2 },
        { content: 'saldo N: <b>' + @uzytek.saldo_n.round(1).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width/3, inline_format: true }
      ]
    ]
  end
  
  # informacje ogólne o uprawie
  def ogolne
    [
      [
        { content: 'oznaczenie pola: <b>' + @uzytek.name + "</b>", border_width: 0, inline_format: true, padding: [ 1.mm, 1.mm, 1.mm, 2.mm ], width: @o.bounds.width*3/4 },
        { content: 'powierzchnia: <b>' + @uzytek.powierzchnia.round(1).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width/4, inline_format: true }
      ]
    ]
  end

  # wyniki badań
  def wyniki
    [
      [
        {
          content: uprawy,
          border_width: [0, 0.2.mm, 0, 0],
          width: @o.bounds.width/5
        },
        {
          content: azot_dzialajacy,
          border_width: [0, 0.2.mm, 0, 0],
          width: @o.bounds.width/5
        },
        {
          content: zalecane_dawki,
          border_width: 0,
          width: @o.bounds.width/5*3
        },
      ],
    ]
  end

  def azot_dzialajacy
    [
      [
        {
          content: "<b>N działający</b>",
          border_width: [ 0, 0, 0.2.mm, 0],
          height: 10.8.mm,
          size: 8.pt,
          padding: 3.5.mm,
          width: @o.bounds.width/5,
          inline_format: true,
          align: :center,
        },
      ],
      [
        {
          content: ha_pole,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/5
        },
      ],
      [
        {
          content: ha_pole_azot_dzialajacy,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/5
        },
      ]
    ]
  end

  def ha_pole
    [
      [
        {
          content: "kg/ha",
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0.2.mm, 0.2.mm, 0],
          width: @o.bounds.width/5/2
        },
        {
          content: "kg/pole",
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0.2.mm, 0],
          width: @o.bounds.width/5/2
        },
      ]
    ]
  end

  def ha_pole_azot_dzialajacy
    [
      [
        {
          content: @uzytek.azot_mineralny_ha.round(1).to_s,
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0, 0],
          width: @o.bounds.width/5/2
        },
        {
          content: @uzytek.azot_mineralny_pole.round(1).to_s,
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0, 0],
          width: @o.bounds.width/5/2
        },
      ]
    ]
  end
  
  def uprawy
    [
      [
        {
          content: '<b>U P R A W Y</b>',
          padding: 4.mm,
          border_width: 0,
          inline_format: true,
          align: :center,
          size: 8.pt,
          border_width: [ 0, 0.2.mm, 0.2.mm, 0 ],
          height: 10.8.mm,
          width: @o.bounds.width/5,
        },
      ],
      [
        {
          content: @uprawa,
          border_width: [ 0, 0.2.mm, 0.mm, 0 ]
        },
      ]
    ]
  end
  
  def zalecane_dawki
    [
      [
        {
        content: '<b>zalecane dawki do zastosowania</b>',
        padding: [ 1.mm, 0, 1.5.mm, 0 ],
        inline_format: true,
        align: :center,
        size: 8.pt,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*3
        }
      ],
      [
        {
          content: [
          [
              {
                content: dawki_ha,
                border_width: [0,0,0,0],
                width: @o.bounds.width/5*1.5,
              },
              {
                content: dawki_pole,
                border_width: [0,0,0,0],
                width: @o.bounds.width/5*1.5,
              },
            ]
          ],
          border_width: 0,
        }
      ]
    ]
  end
  
  def dawki_ha
    [
      [
        content: naglowek_pierwiastki_jednostki,
        padding: 1.mm,
        border_width: [ 0, 0.2.mm, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
      [
        content: naglowek_pierwiastki,
        padding: 1.mm,
        border_width: [ 0, 0.2.mm, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
      [
        content: pierwiastki_ha,
        padding: 1.mm,
        border_width: [ 0, 0, 0, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
    ]
  end


  def dawki_pole
    [
      [
        content: naglowek_pierwiastki_jednostki_pole,
        padding: 1.mm,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
      [
        content: naglowek_pierwiastki,
        padding: 1.mm,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
      [
        content: pierwiastki_pole,
        padding: 1.mm,
        border_width: [ 0, 0, 0.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/5*1.5,
      ],
    ]
  end
  
  def naglowek_pierwiastki
    [
      [
        {
          content: 'N',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          height: 5.4.mm,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '<strikethrough>P<sub>2</sub>O<sub>5</sub></strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '<strikethrough>K<sub>2</sub>O</strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: mg_naglowek,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: cao_naglowek,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0.2.mm, 0.2.mm ],
          width: @o.bounds.width/5*1.5/5
        },
      ]
    ]
  end

  def mg_naglowek
    unless @uzytek.mg_wynik_ha.nil?
      'MgO'
    else
      '<strikethrough>MgO</strikethrough>'
    end
  end
  
  def mg_ha
    unless @uzytek.mg_wynik_ha.nil?
      @uzytek.mg_wynik_ha.round(1).to_s
    else
      '-'
    end
  end

  def mg_pole
    unless @uzytek.mg_wynik_ha.nil?
      @uzytek.mg_wynik_pole.round(1).to_s
    else
      '-'
    end
  end
  
  def cao_naglowek
    unless @uzytek.cao.nil?
      'CaO'
    else
      '<strikethrough>CaO</strikethrough>'
    end
  end
  
  def cao_ha
    unless @uzytek.cao.nil?
      @uzytek.cao_ha.round(1).to_s
    else
      '-'
    end
  end

  def cao_pole
    unless @uzytek.cao.nil?
      @uzytek.cao_pole.round(1).to_s
    else
      '-'
    end
  end
  
  def naglowek_pierwiastki_jednostki
    [
      [
        {
          content: 'kg/ha',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5/5*4*1.5,
          height: 5.4.mm,
        },
        {
          content: 't/ha',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/5/5*1.5,
          height: 5.4.mm,
        },
      ]
    ]
  end

  def naglowek_pierwiastki_jednostki_pole
    [
      [
        {
          content: 'kg/pole',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5/5*4*1.5,
          height: 5.4.mm,
        },
        {
          content: 't/pole',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/5/5*1.5,
          height: 5.4.mm,
        },
      ]
    ]
  end
  
  def pierwiastki_ha
    [
      [
        {
          content: @uzytek.azot_mineralny_ha_w_nawozie.round(1).to_s,
          align: :center,
          size: 8.pt,
          padding: [ 1.mm, 0, 0, 0 ],
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: mg_ha,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: cao_ha,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
      ]
    ]
  end

  def pierwiastki_pole
    [
      [
        {
          content: @uzytek.azot_mineralny_pole_w_nawozie.round(1).to_s,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: mg_pole,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: cao_pole,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
      ]
    ]
  end
  
  # szczegóły uprawy
  def uprawa
    @uprawa.push( 
      [ 
        { content: '<b>Roślina:</b> ' + @uzytek.roslina.name + ' (' + @uzytek.roslina.rodzajuprawy.name + ')',
          padding: 2.mm,
          border_width: 0,
          inline_format: true,
          size: 8.pt,
          border_width: [ 0, 0.mm, 0, 0 ],
          width: @o.bounds.width/5 }
      ]
    )
  end

  # przedplon
  def przedplon
    # jeśli wybrano roślinę na przedplon
    if @uzytek.roslinaprzedplon_id > 1
      @uprawa.push(
        [
          { content: '<b>Przedplon:</b> ' + @uzytek.roslinaprzedplon.name,
            padding: 2.mm,
            border_width: 0,
            inline_format: true,
            size: 8.pt,
            border_width: [ 0, 0.mm, 0, 0 ],
            width: @o.bounds.width/5 }
        ])
    end
  end

  # bobowata
  def bobowata
    # jeśli wybrano roślinę na przedplon
    if @uzytek.bobowata_id > 1
      @uprawa.push(
        [
          { content: '<b>Bobowate:</b> ' + @uzytek.bobowata.name,
            padding: 2.mm,
            border_width: 0,
            inline_format: true,
            size: 8.pt,
            border_width: [ 0, 0.mm, 0, 0 ],
            width: @o.bounds.width/5 }
        ])
    end
  end

end
