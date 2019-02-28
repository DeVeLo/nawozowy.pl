class WspwykorzystaniaSerializer < ActiveModel::Serializer
  attributes :id, :name, :wsp_fosfor_i_rok, :wsp_potas_i_rok, :wsp_magnez_i_rok, :wsp_fosfor_ii_rok, :wsp_potas_ii_rok, :wsp_magnez_ii_rok, :text, :value

  def text
    object.name
  end

  def value
    object.id
  end
end
