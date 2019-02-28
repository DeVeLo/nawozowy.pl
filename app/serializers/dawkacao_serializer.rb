class DawkacaoSerializer < ActiveModel::Serializer
  attributes :id, :od, :do, :dawka
  has_one :kategoria
  has_one :grunt
  has_one :potrzeba
end
