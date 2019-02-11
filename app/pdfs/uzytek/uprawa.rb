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

    @o.text 'Azot stusujemy z podziałem na dawki.'
    
  end

  # podsumowanie
  def podsumowanie
    [
      [
        { content: 'nawożenie azotem: <b>' + @uzytek.azot.to_s + "</b> kg N/ha/rok", border_width: 0, inline_format: true, padding: [ 1.mm, 1.mm, 1.mm, 2.mm ], width: @o.bounds.width/3 },
        { content: 'w tym z nawozów naturalnych <b>' + @uzytek.azot_naturalny_ha.round(2).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :center, width: @o.bounds.width/3, inline_format: true },
        { content: 'saldo N: <b>' + @uzytek.saldo_n.round(2).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width/3, inline_format: true }
      ]
    ]
  end
  
  # informacje ogólne o uprawie
  def ogolne
    [
      [
        { content: 'oznaczenie pola: <b>' + @uzytek.name + "</b>", border_width: 0, inline_format: true, padding: [ 1.mm, 1.mm, 1.mm, 2.mm ], width: @o.bounds.width*3/4 },
        { content: 'powierzchnia: <b>' + @uzytek.powierzchnia.round(2).to_s + '</b> ha', border_width: 0, padding: [ 1.mm, 2.mm, 1.mm, 1.mm ], align: :right, width: @o.bounds.width/4, inline_format: true }
      ]
    ]
  end

  # wyniki badań
  def wyniki
    [
      [
        {
          content: uprawy,
          border_width: 0,
        },
        {
          content: dawki_ha,
          border_width: [ 0, 0.2.mm, 0, 0 ],
        },
        {
          content: dawki_pole,
          border_width: 0,
        },
      ],
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
          width: @o.bounds.width/3
        },
      ],
      [
        { content: @uprawa,
          border_width: [ 0, 0.2.mm, 0.mm, 0 ] },
      ]
    ]
  end
  
  def dawki_ha
    [
      [
        content: '<b>zalecane dawki w kg/1 ha</b>',
        padding: [ 1.mm, 0, 1.5.mm, 0 ],
        border_width: 0,
        inline_format: true,
        align: :center,
        size: 8.pt,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
      ],
      [
        content: naglowek_pierwiastki,
        padding: 1.mm,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
      ],
      [
        content: pierwiastki_ha,
        padding: 1.mm,
        border_width: [ 0, 0, 0.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
      ],
    ]
  end

  def dawki_pole
    [
      [
        content: '<b>zalecane dawki w kg/pole</b>',
        padding: [ 1.mm, 0, 1.5.mm, 0 ],
        border_width: 0,
        inline_format: true,
        align: :center,
        size: 8.pt,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
      ],
      [
        content: naglowek_pierwiastki,
        padding: 1.mm,
        border_width: [ 0, 0, 0.2.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
      ],
      [
        content: pierwiastki_pole,
        padding: 1.mm,
        border_width: [ 0, 0, 0.mm, 0 ],
        height: 5.4.mm,
        width: @o.bounds.width/3
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
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5.5
        },
        {
          content: '<strikethrough>P2O5</strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '<strikethrough>K2O</strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '<strikethrough>MgO</strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '<strikethrough>CaO(t)</strikethrough>',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          inline_format: true,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
      ]
    ]
  end

  def pierwiastki_ha
    [
      [
        {
          content: @uzytek.azot.round(2).to_s,
          align: :center,
          size: 8.pt,
          padding: [ 1.mm, 0, 0, 0 ],
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5.5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
      ]
    ]
  end

  def pierwiastki_pole
    [
      [
        {
          content: @uzytek.azot_pole.round(2).to_s,
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5.5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
        },
        {
          content: '',
          align: :center,
          size: 8.pt,
          padding: 1.mm,
          border_width: [ 0, 0, 0, 0 ],
          width: @o.bounds.width/3/5
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
