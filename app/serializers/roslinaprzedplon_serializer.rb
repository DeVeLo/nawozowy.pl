class RoslinaprzedplonSerializer < ActiveModel::Serializer
  attributes :id, :name, :n, :text, :value

  def text
    object.name
  end

  def value
    object.id
  end
end
