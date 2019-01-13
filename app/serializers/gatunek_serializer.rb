class GatunekSerializer < ActiveModel::Serializer
  attributes :text, :value

  def text
    object.name
  end

  def value
    object.id
  end
  
end
