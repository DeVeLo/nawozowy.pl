class AddPlonprzedplonowejToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :plonprzedplonowej, :decimal
  end
end
