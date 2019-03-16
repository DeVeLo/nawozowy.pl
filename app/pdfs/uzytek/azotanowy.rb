# coding: utf-8
class Uzytek::Azotanowy

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
               [
                 { content: if @zlecenie.bilansn then podsumowanie else '' end,
                   border_width: 0 },
               ],
             ], {
               header: true
             })

    @o.move_down 5.pt

    lp = 0
    @uzytek.nawozynaturalne.each do |nn|

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
                       ' t/' + @uzytek.powierzchnia.round(1).to_s +
                       ' ha (pole) - (' +
                       (nn.wykorzystany_azot * @uzytek.powierzchnia).round(1).to_s + ' kg N/ ' + @uzytek.powierzchnia.round(1).to_s + ' ha (pole) ' +
                       'w tym działający ' + (nn.wykorzystany_azot_dzialajacy * @uzytek.powierzchnia).round(1).to_s +
                       ' kg N/' + @uzytek.powierzchnia.round(1).to_s + ' ha (pole)' +
                       ')',
                     border_width: 0,
                     padding: [1.mm, 0, 0, 3.mm ]
                   }
                 ],
               ])
      @o.move_down 10.pt

    end
  
  end

  # podsumowanie
  def podsumowanie
    [
      [
        { content: 'bilans azotu <b>' + @uzytek.saldo_n.round(1).to_s + '</b>', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width, inline_format: true }
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
          width: @o.bounds.width/3
        },
        {
          content: azot_dzialajacy,
          border_width: [0, 0.2.mm, 0, 0],
          width: @o.bounds.width/3
        },
        {
          content: zalecane_dawki,
          border_width: 0,
          width: @o.bounds.width/3
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
          width: @o.bounds.width/3,
          inline_format: true,
          align: :center,
        },
      ],
      [
        {
          content: ha_pole,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/6
        },
      ],
      [
        {
          content: ha_pole_azot_dzialajacy,
          border_width: 0,
          height: 5.4.mm,
          width: @o.bounds.width/6,
        },
      ]
    ]
  end

  def ha_pole
    [
      [
        {
          content: "N kg/ha",
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0.2.mm, 0.2.mm, 0],
          width: @o.bounds.width/6
        },
        {
          content: "N kg/pole",
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0.2.mm, 0],
          width: @o.bounds.width/6
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
          width: @o.bounds.width/6
        },
        {
          content: @uzytek.azot_mineralny_pole.round.to_s,
          height: 5.4.mm,
          padding: 1.mm,
          size: 8.pt,
          align: :center,
          border_width: [0, 0, 0, 0],
          width: @o.bounds.width/6
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
          width: @o.bounds.width/3,
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
        content: "<b>Zalecane dawki nawozów mineralnych\nw czystym składniku do zastosowania</b>",
        inline_format: true,
        align: :center,
        padding: 2.mm,
        size: 8.pt,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 10.8.mm,
        width: @o.bounds.width/3
        }
      ],
      [
        {
          content: [
          [
              {
                content: dawki_ha,
                border_width: [0,0,0,0],
                width: @o.bounds.width/6,
              },
              {
                content: dawki_pole,
                border_width: [0,0,0,0],
                width: @o.bounds.width/6,
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
        width: @o.bounds.width/6,
      ],
      [
        content: pierwiastki_ha,
        padding: 1.mm,
        border_width: [ 0, 0, 0, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/6,
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
        width: @o.bounds.width/6,
      ],
      [
        content: pierwiastki_pole,
        padding: 1.mm,
        border_width: [ 0, 0, 0.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/6,
      ],
    ]
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
          width: @o.bounds.width/6,
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
          width: @o.bounds.width/6,
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
          width: @o.bounds.width/6
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
          width: @o.bounds.width/6
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
          width: @o.bounds.width/3 }
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
            width: @o.bounds.width/3 }
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
            width: @o.bounds.width/3 }
        ])
    end
  end

end
