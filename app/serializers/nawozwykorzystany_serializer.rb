class NawozwykorzystanySerializer < ActiveModel::Serializer
  attributes :id, :ilosc
  has_one :animal
  has_one :nawoznaturalny
end
