class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza
  has_one :kategoria
  has_one :rodzajuprawy
end
