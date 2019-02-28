class OcenamagnezSerializer < ActiveModel::Serializer
  attributes :id, :powyzej, :ponizej
  has_one :ocena
  has_one :kategoria
end
