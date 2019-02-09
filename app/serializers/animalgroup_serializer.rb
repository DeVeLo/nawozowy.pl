class AnimalgroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :text, :animalsname
  has_one :instytucja
  has_one :rolnik
  has_one :zlecenie
  has_many :animals

  def value
    object.id
  end

  def text
    object.animalsname
  end
end
