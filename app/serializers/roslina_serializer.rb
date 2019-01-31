class RoslinaSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :value, :pobranie, :rodzajuprawy

  def text
    object.name
  end

  def value
    object.id
  end

  belongs_to :rodzajuprawy
  
end
