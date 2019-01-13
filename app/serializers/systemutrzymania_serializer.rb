class SystemutrzymaniaSerializer < ActiveModel::Serializer
  attributes :id, :produkcja, :zawartosc, :zwierze_id, :jednostkautrzymania, :jednostkautrzymania_id, :zwierze_id
end
