class NawoznaturalnySerializer < ActiveModel::Serializer
  attributes :id, :ilosc, :sezon_name, :grupa
  belongs_to :animalgroup

  def grupa
    object.animalgroup.animalsname
  end

  def sezon_name
    object.sezon.name
  end
end
