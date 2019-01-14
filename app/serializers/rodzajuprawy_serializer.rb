class RodzajuprawySerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :value

  def text
    object.name
  end

  def value
    object.id
  end
end
