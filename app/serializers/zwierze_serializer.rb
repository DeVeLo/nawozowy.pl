class ZwierzeSerializer < ActiveModel::Serializer
  attributes :id, :name, :gatunek_id, :wspolczynnik, :koncentracja, :value, :text, :rownowazniki

  def value
    object.id
  end

  def text
    object.name
  end
  
end
