class KategoriaSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :value, :zasob

  def text
    object.name
  end

  def value
    object.id
  end
end
