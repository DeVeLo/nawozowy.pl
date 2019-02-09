class RownowaznikSerializer < ActiveModel::Serializer
  attributes :id, :wariant, :value, :text

  def value
    object.id
  end

  def text
    object.wariant
  end
end
