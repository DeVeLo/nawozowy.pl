class AddWspolczynnikiToRoslinaprzedplon < ActiveRecord::Migration[5.0]
  def change
    add_column :roslinaprzedplony, :wsp_fosfor_i_rok, :decimal
    add_column :roslinaprzedplony, :wsp_potas_i_rok, :decimal
    add_column :roslinaprzedplony, :wsp_magnez_i_rok, :decimal
    add_column :roslinaprzedplony, :wsp_fosfor_ii_rok, :decimal
    add_column :roslinaprzedplony, :wsp_potas_ii_rok, :decimal
    add_column :roslinaprzedplony, :wsp_magnez_ii_rok, :decimal
  end
end
