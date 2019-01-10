class GminaSerializer < ActiveModel::Serializer
  attributes :id, :name, :name_dod, :text, :value

  def text
    object.name
  end

  def value
    object.id
  end
end
