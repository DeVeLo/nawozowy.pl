class GminaSerializer < ActiveModel::Serializer
  attributes :id, :name, :name_dod, :text, :value, :plynne, :stale
 
  
  def text
    object.name + ' (' + object.name_dod + ')'
  end

  def value
    object.id
  end
end
