class NazwautrzymaniaSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :value

  def value
    object.id
  end

  def text
    object.name
  end
end
