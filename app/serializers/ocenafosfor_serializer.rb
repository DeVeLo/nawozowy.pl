class OcenafosforSerializer < ActiveModel::Serializer
  attributes :id, :weglanowa, :powyzej, :ponizej
  has_one :kategoria
  has_one :ocena
end
