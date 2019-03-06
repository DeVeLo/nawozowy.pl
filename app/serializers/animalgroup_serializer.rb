class AnimalgroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :text, :animalsname, :produkt, :pozostalynawoz,
             :produkcja_azot, :pozostaly_azot, :produkcja_fosfor, :pozostaly_fosfor,
             :produkcja_potas, :pozostaly_potas, :maksymalna_dawka
  has_one :instytucja
  has_one :rolnik
  has_one :zlecenie
  has_many :animals

  def value
    object.id
  end

  def text
    object.animalsname
  end
end
