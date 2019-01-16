class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :instytucja_id, :rolnik_id, :zlecenie_id, :zwierze_id, :nazwautrzymania_id, :systemutrzymania_id, :sztuk, :nazwautrzymania, :gatunek_id, :produkt, :azot, :specjalnezywienie, :badania, :zawartosc, :zawartosc_wynikowa

  belongs_to :zlecenie
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania

  def gatunek_id
    object.zwierze.gatunek_id
  end
end
