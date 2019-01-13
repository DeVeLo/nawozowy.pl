class ZlecenieSerializer < ActiveModel::Serializer
  attributes :id, :name, :sprawa, :instytucja_id, :rolnik_id, :wariant_id, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc, :powierzchnia
  has_one :instytucja
  has_one :rolnik
  has_one :wariant
end
