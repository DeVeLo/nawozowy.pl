# coding: utf-8
class Uzytek::Pelny

  def initialize(o, uzytek)

    @o = o
    @uzytek = uzytek
    @rolnik = uzytek.rolnik
    @zlecenie = uzytek.zlecenie

    @uprawa = []
    uprawa
    # przedplon
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
             ], {
               header: true
             })
    @o.table([
               [
                 { content: if @zlecenie.bilansn then podsumowanie else '' end,
                   border_width: 0 },
               ]
             ])

    
    lp = 0
    @uzytek.nawozynaturalne.each do |nn|

#      @o.move_down 10.pt
      lp = lp + 1
      @o.text ++lp.to_s + ') Nawóz naturalny - ' + nn.animalgroup.animalsname.downcase + ' - ' + nn.sezon.name + ':'
      @o.table([
                 [
                   {
                     content: "•",
                     border_width: 0,
                     padding: [1.mm, 0, 0, 9.mm ]
                   },
                   {
                     content: nn.ilosc.round.to_s + ' t/ha (' +
                       nn.wykorzystany_azot.round(1).to_s + ' kg N/ha ' +
                       'w tym działający ' + nn.wykorzystany_azot_dzialajacy.round(1).to_s +
                       ' kg N/ ha' +
                       ')',
                     border_width: 0,
                     padding: [1.mm, 0, 0, 3.mm ]
                   }
                 ],
                 [
                   {
                     content: "•",
                     border_width: 0,
                     padding: [1.mm, 0, 0, 9.mm ]
                   },
                   {
                     content: (nn.ilosc * @uzytek.powierzchnia).round.to_s +
                       ' t/' + sprintf("%.2f", @uzytek.powierzchnia.round(2)) +
                       ' ha - (' +
                       (nn.wykorzystany_azot * @uzytek.powierzchnia).round(1).to_s + ' kg N/ ' + sprintf("%.2f", @uzytek.powierzchnia.round(2)) + ' ha ' +
                       'w tym działający ' + (nn.wykorzystany_azot_dzialajacy * @uzytek.powierzchnia).round(1).to_s +
                       ' kg N/' + sprintf("%.2f", @uzytek.powierzchnia.round(2)) + ' ha ' +
                       ')',
                     border_width: 0,
                     padding: [1.mm, 0, 0, 3.mm ]
                   }
                 ],
               ])
    end
  
  end

  # podsumowanie
  def podsumowanie
    [
      [
        { content: 'Bilans azotu <b>' + @uzytek.saldo_n.round.to_s + '</b>', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width, inline_format: true }
      ]
    ]
  end
  
  # informacje ogólne o uprawie
  def ogolne
    [
      [
        { content: @uzytek.lp.to_s + '. oznaczenie pola: <b>' + @uzytek.name + "</b>", border_width: 0, inline_format: true, padding: [ 1.mm, 1.mm, 1.mm, 2.mm ], width: @o.bounds.width*3/4 },
        { content: 'powierzchnia: <b>' + sprintf("%.2f", @uzytek.powierzchnia.round(2)).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width/4, inline_format: true }
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
          width: @o.bounds.width/5*1.5
        },
        {
          content: azot_dzialajacy,
          border_width: [0, 0.2.mm, 0, 0],
          width: @o.bounds.width/5*3/5
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
          content: "<b>N działający\nz nawozów min.</b>",
          border_width: [ 0, 0, 0.2.mm, 0],
          height: 10.8.mm,
          size: 8.pt,
          padding: 2.mm,
          width: @o.bounds.width/5*3/5,
          inline_format: true,
          align: :center,
        },
      ],
      [
        {
          content: ha_pole,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/5*3/5
        },
      ],
      [
        {
          content: ha_pole_azot_dzialajacy,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/5*3/5
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
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: "kg/pole",
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0.2.mm, 0],
          width: @o.bounds.width/5*1.5/5
        },
      ]
    ]
  end

  def ha_pole_azot_dzialajacy
    [
      [
        {
          content: @uzytek.azot_mineralny_ha.round.to_s,
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0, 0],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: @uzytek.azot_mineralny_pole.round.to_s,
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0, 0],
          width: @o.bounds.width/5*1.5/5
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
          border_width: [ 0, 0.mm, 0.2.mm, 0 ],
          height: 10.8.mm,
          width: @o.bounds.width/5*1.4,
        },
      ],
      [
        {
          content: @uprawa,
          border_width: [ 0, 0.mm, 0.mm, 0 ]
        },
      ]
    ]
  end
  
  def zalecane_dawki
    [
      [
        {
        content: '<b>Zalecane dawki nawozów mineralnych w czystym składniku do zastosowania</b>',
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
          content: fosfor_naglowek,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0.2.mm, 0, 0 ],
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: potas_naglowek,
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

  def fosfor_naglowek
    unless @uzytek.wynik_fosfor.nil?
      'P<sub>2</sub>O<sub>5</sub>'
    else
      'P<sub>2</sub>O<sub>5</sub>'
    end
  end

  def potas_naglowek
    unless @uzytek.wynik_potas.nil?
      'K<sub>2</sub>O'
    else
      'K<sub>2</sub>O'
    end
  end

  def mg_naglowek
    unless @uzytek.mg_wynik_ha.nil?
      'MgO'
    else
      'MgO'
    end
  end
  
  def mg_ha
    unless @uzytek.mg_wynik_ha.nil?
      @uzytek.mg_wynik_ha.round.to_s
    else
      '0'
    end
  end

  def mg_pole
    unless @uzytek.mg_wynik_ha.nil?
      @uzytek.mg_wynik_pole.round.to_s
    else
      '0'
    end
  end
  
  def cao_naglowek
    unless @uzytek.cao.nil?
      'CaO'
    else
      'CaO'
    end
  end

  def fosfor_wynik_ha
    unless @uzytek.wynik_fosfor.nil?
      @uzytek.wynik_fosfor.round.to_s
    else
      '0'
    end
  end

  def potas_wynik_ha
    unless @uzytek.wynik_potas.nil?
      @uzytek.wynik_potas.round.to_s
    else
      '0'
    end
  end

  def fosfor_wynik_pole
    unless @uzytek.wynik_fosfor.nil?
      (@uzytek.wynik_fosfor * @uzytek.powierzchnia).round.to_s
    else
      '0'
    end
  end

  def potas_wynik_pole
    unless @uzytek.wynik_potas.nil?
      (@uzytek.wynik_potas * @uzytek.powierzchnia).round.to_s
    else
      '0'
    end
  end
  
  def cao_ha
    unless @uzytek.cao_ha.nil?
      @uzytek.cao_ha.round.to_s
    else
      '0'
    end
  end

  def cao_pole
    unless @uzytek.cao_ha.nil?
      @uzytek.cao_pole.round.to_s
    else
      '0'
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
          content: @uzytek.azot_mineralny_ha_w_nawozie.round.to_s,
          align: :center,
          size: 8.pt,
          padding: [ 1.mm, 0, 0, 0 ],
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: fosfor_wynik_ha,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: potas_wynik_ha,
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
          content: @uzytek.azot_mineralny_pole_w_nawozie.round.to_s,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: fosfor_wynik_pole,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          height: 5.4.mm,
          width: @o.bounds.width/5*1.5/5
        },
        {
          content: potas_wynik_pole,
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
          width: @o.bounds.width/5*1.4 }
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
