class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza, :instytucja_id, :rolnik_id, :zlecenie_id, :kategoria_id
  
  has_one :kategoria
  has_one :rodzajuprawy
end
