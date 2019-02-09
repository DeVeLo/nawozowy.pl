class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :instytucja_id, :rolnik_id, :zlecenie_id, :zwierze_id,
             :nazwautrzymania_id, :systemutrzymania_id, :sztuk, :nazwautrzymania,
             :gatunek_id, :produkt, :azot, :specjalnezywienie, :badania, :zawartosc,
             :zawartosc_wynikowa, :rownowaznik_id, :pozostalynawoz, :pozostalyazot,
             :animalgroup_id

  belongs_to :zlecenie
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania
  belongs_to :rownowaznik
  belongs_to :animalgroup

  def gatunek_id
    object.zwierze.gatunek_id
  end
end
