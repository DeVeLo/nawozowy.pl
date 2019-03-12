# coding: utf-8
class Rolnik::Dane

  def initialize(o)

    @o = o
    @rolnik = o.zlecenie.rolnik
    @zlecenie = o.zlecenie

    @o.table([
               [
                 { content: gospodarstwo, border_width: 0,
                   width: @o.bounds.width/5*3
                 },
                 { content: adres, border_width: 0,
                   width: @o.bounds.width/5*2
                 },
               ]
             ])

  end

  def adres
    [
      [
        { content: "Miejscowość:", border_width: 0, padding: [ 0, 0, 0, 0 ] },
        { content: "<b>" + @rolnik.miejscowosc.to_s + "</b>", border_width: 0, padding: [ 0, 0, 0, 2.mm ], inline_format: true }
      ],
      [
        { content: "Gmina:", border_width: 0, padding: [ 2.mm, 0, 0, 0 ] },
        { content: "<b>" + @rolnik.gmina.name + "</b>", border_width: 0, padding: [ 2.mm, 0, 0, 2.mm ], inline_format: true }
      ],
      [
        { content: "Województwo:", border_width: 0, padding: [ 2.mm, 0, 0, 0 ] },
        { content: "<b>" + @rolnik.wojewodztwo.name + "</b>", border_width: 0, padding: [ 2.mm, 0, 0, 2.mm ], inline_format: true }
      ]
    ]
  end

  def gospodarstwo
    [
      [
        { content: "Gospodarstwo:", border_width: 0, padding: [ 0, 0, 0, 0 ], inline_format: true },
        { content: "<b>" + @rolnik.gname + "</b>", border_width: 0, padding: [ 0, 0, 0, 2.mm ], inline_format: true }
      ],
      [
        { content: "NIG:", border_width: 0, padding: [ 2.mm, 0, 0, 0 ], inline_format: true },
        { content: "<b>" + @rolnik.nig + "</b>", border_width: 0, padding: [ 2.mm, 0, 0, 2.mm ], inline_format: true }
      ],
      [
        { content: "Rok Gospodarczy:", border_width: 0, padding: [ 2.mm, 0, 0, 0 ], inline_format: true },
        { content: "<b>" + @zlecenie.name + "</b>", border_width: 0, padding: [ 2.mm, 0, 0, 2.mm ], inline_format: true }
      ],
    ]
  end
  
end
